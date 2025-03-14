import React, { useState } from 'react';
import { Form, Input, Button, Card, message } from 'antd';
import axios from 'axios';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';

const { TextArea } = Input;

const ReportForm = () => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);

  const onFinish = async (values) => {
    setLoading(true);
    try {
      const response = await axios.post('/api/student/reports', values);
      if (response.data.success) {
        message.success('项目提交成功');
        form.resetFields();
      } else {
        message.error(response.data.message || '提交失败');
      }
    } catch (error) {
      message.error('服务器错误，请稍后再试');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Card title="提交项目" className="report-form-card">
      <Form
        form={form}
        name="reportForm"
        layout="vertical"
        onFinish={onFinish}
      >
        <Form.Item
          name="title"
          label="项目标题"
          rules={[{ required: true, message: '请输入项目标题' }]}
        >
          <Input placeholder="请输入本周项目标题" />
        </Form.Item>

        <Form.Item
          name="content"
          label="项目内容"
          rules={[{ required: true, message: '请输入项目内容' }]}
        >
          <ReactQuill 
            theme="snow" 
            placeholder="请详细描述本周的研究工作..." 
          />
        </Form.Item>

        <Form.Item
          name="summary"
          label="工作总结"
          rules={[{ required: true, message: '请输入工作总结' }]}
        >
          <TextArea 
            rows={4} 
            placeholder="请总结本周的主要工作成果和遇到的问题" 
          />
        </Form.Item>

        <Form.Item
          name="plan"
          label="下周计划"
          rules={[{ required: true, message: '请输入下周计划' }]}
        >
          <TextArea 
            rows={4} 
            placeholder="请描述下周的工作计划" 
          />
        </Form.Item>

        <Form.Item>
          <Button type="primary" htmlType="submit" loading={loading}>
            提交项目
          </Button>
        </Form.Item>
      </Form>
    </Card>
  );
};

export default ReportForm;