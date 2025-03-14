import React, { useState } from 'react';
import { Form, Input, Button, Select, Card, message } from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import axios from 'axios';
import './Login.css';

const { Option } = Select;

const Login = () => {
  const [loading, setLoading] = useState(false);

  const onFinish = async (values) => {
    setLoading(true);
    try {
      const response = await axios.post('/api/login', values);
      if (response.data.success) {
        message.success('登录成功');
        // 根据用户类型重定向
        const { userType } = values;
        window.location.href = `/${userType}`;
      } else {
        message.error(response.data.message || '登录失败');
      }
    } catch (error) {
      message.error('服务器错误，请稍后再试');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-container">
      <Card title="研究生/学生项目管理系统" className="login-card">
        <Form
          name="login"
          initialValues={{ userType: 'student' }}
          onFinish={onFinish}
        >
          <Form.Item
            name="userType"
            rules={[{ required: true, message: '请选择用户类型' }]}
          >
            <Select placeholder="请选择用户类型">
              <Option value="student">学生</Option>
              <Option value="teacher">教师</Option>
              <Option value="admin">管理员</Option>
            </Select>
          </Form.Item>

          <Form.Item
            name="username"
            rules={[{ required: true, message: '请输入用户名' }]}
          >
            <Input 
              prefix={<UserOutlined />} 
              placeholder="用户名" 
            />
          </Form.Item>

          <Form.Item
            name="password"
            rules={[{ required: true, message: '请输入密码' }]}
          >
            <Input.Password 
              prefix={<LockOutlined />} 
              placeholder="密码" 
            />
          </Form.Item>

          <Form.Item>
            <Button type="primary" htmlType="submit" loading={loading} block>
              登录
            </Button>
          </Form.Item>
        </Form>
      </Card>
    </div>
  );
};

export default Login;