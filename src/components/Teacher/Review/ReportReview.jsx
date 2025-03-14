import React, { useState, useEffect } from 'react';
import { Card, Table, Tag, Button, Modal, Form, Input, Rate, message } from 'antd';
import { EyeOutlined, CheckOutlined } from '@ant-design/icons';
import axios from 'axios';

const { TextArea } = Input;

const ReportReview = () => {
  const [reports, setReports] = useState([]);
  const [loading, setLoading] = useState(true);
  const [reviewModalVisible, setReviewModalVisible] = useState(false);
  const [currentReport, setCurrentReport] = useState(null);
  const [form] = Form.useForm();

  useEffect(() => {
    fetchReports();
  }, []);

  const fetchReports = async () => {
    try {
      const response = await axios.get('/api/teacher/reports/pending');
      setReports(response.data);
    } catch (error) {
      message.error('获取待审阅项目失败');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const handleView = (report) => {
    setCurrentReport(report);
    setReviewModalVisible(true);
    form.resetFields();
  };

  const handleReviewSubmit = async () => {
    try {
      const values = await form.validateFields();
      const response = await axios.post(`/api/teacher/reports/${currentReport.id}/review`, values);
      
      if (response.data.success) {
        message.success('项目审阅成功');
        setReviewModalVisible(false);
        fetchReports(); // 刷新列表
      } else {
        message.error(response.data.message || '审阅失败');
      }
    } catch (error) {
      if (error.errorFields) {
        return; // 表单验证错误
      }
      message.error('服务器错误，请稍后再试');
      console.error(error);
    }
  };

  const columns = [
    {
      title: '学生姓名',
      dataIndex: 'studentName',
      key: 'studentName',
    },
    {
      title: '项目标题',
      dataIndex: 'title',
      key: 'title',
    },
    {
      title: '提交时间',
      dataIndex: 'submitTime',
      key: 'submitTime',
      render: (text) => new Date(text).toLocaleString(),
    },
    {
      title: '状态',
      dataIndex: 'status',
      key: 'status',
      render: () => <Tag color="orange">待审阅</Tag>,
    },
    {
      title: '操作',
      key: 'action',
      render: (_, record) => (
        <Button 
          type="primary" 
          icon={<EyeOutlined />} 
          onClick={() => handleView(record)}
        >
          查看并审阅
        </Button>
      ),
    },
  ];

  return (
    <div>
      <Card title="待审阅项目列表" className="report-review-card">
        <Table 
          columns={columns} 
          dataSource={reports} 
          rowKey="id" 
          loading={loading}
          pagination={{ pageSize: 10 }}
        />
      </Card>

      <Modal
        title="项目审阅"
        visible={reviewModalVisible}
        onCancel={() => setReviewModalVisible(false)}
        footer={[
          <Button key="cancel" onClick={() => setReviewModalVisible(false)}>
            取消
          </Button>,
          <Button 
            key="submit" 
            type="primary" 
            icon={<CheckOutlined />} 
            onClick={handleReviewSubmit}
          >
            提交审阅
          </Button>,
        ]}
        width={800}
      >
        {currentReport && (
          <div>
            <h3>{currentReport.title}</h3>
            <p><strong>学生：</strong>{currentReport.studentName}</p>
            <p><strong>提交时间：</strong>{new Date(currentReport.submitTime).toLocaleString()}</p>
            
            <Card title="项目内容" style={{ marginBottom: 16 }}>
              <div dangerouslySetInnerHTML={{ __html: currentReport.content }} />
            </Card>
            
            <Card title="工作总结" style={{ marginBottom: 16 }}>
              <p>{currentReport.summary}</p>
            </Card>
            
            <Card title="下周计划" style={{ marginBottom: 16 }}>
              <p>{currentReport.plan}</p>
            </Card>
            
            <Form
              form={form}
              layout="vertical"
            >
              <Form.Item
                name="score"
                label="评分"
                rules={[{ required: true, message: '请给本项目评分' }]}
              >
                <Rate allowHalf />
              </Form.Item>
              
              <Form.Item
                name="comment"
                label="评语"
                rules={[{ required: true, message: '请输入评语' }]}
              >
                <TextArea rows={4} placeholder="请输入对本项目的评语和建议" />
              </Form.Item>
            </Form>
          </div>
        )}
      </Modal>
    </div>
  );
};

export default ReportReview;