import React, { useState, useEffect } from 'react';
import { Card, Table, Button, Modal, Form, Input, Popconfirm, message } from 'antd';
import { PlusOutlined, EditOutlined, DeleteOutlined } from '@ant-design/icons';
import axios from 'axios';

const LaboratoryManagement = () => {
  const [laboratories, setLaboratories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [modalVisible, setModalVisible] = useState(false);
  const [modalTitle, setModalTitle] = useState('');
  const [editingLab, setEditingLab] = useState(null);
  const [form] = Form.useForm();

  useEffect(() => {
    fetchLaboratories();
  }, []);

  const fetchLaboratories = async () => {
    try {
      const response = await axios.get('/api/admin/laboratories');
      setLaboratories(response.data);
    } catch (error) {
      message.error('获取实验室列表失败');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const showAddModal = () => {
    setModalTitle('添加实验室');
    setEditingLab(null);
    form.resetFields();
    setModalVisible(true);
  };

  const showEditModal = (lab) => {
    setModalTitle('编辑实验室');
    setEditingLab(lab);
    form.setFieldsValue(lab);
    setModalVisible(true);
  };

  const handleDelete = async (id) => {
    try {
      const response = await axios.delete(`/api/admin/laboratories/${id}`);
      if (response.data.success) {
        message.success('删除成功');
        fetchLaboratories();
      } else {
        message.error(response.data.message || '删除失败');
      }
    } catch (error) {
      message.error('服务器错误，请稍后再试');
      console.error(error);
    }
  };

  const handleModalSubmit = async () => {
    try {
      const values = await form.validateFields();
      
      if (editingLab) {
        // 更新实验室
        const response = await axios.put(`/api/admin/laboratories/${editingLab.id}`, values);
        if (response.data.success) {
          message.success('实验室更新成功');
          setModalVisible(false);
          fetchLaboratories();
        } else {
          message.error(response.data.message || '更新失败');
        }
      } else {
        // 添加实验室
        const response = await axios.post('/api/admin/laboratories', values);
        if (response.data.success) {
          message.success('实验室添加成功');
          setModalVisible(false);
          fetchLaboratories();
        } else {
          message.error(response.data.message || '添加失败');
        }
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
      title: '实验室名称',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: '实验室代码',
      dataIndex: 'code',
      key: 'code',
    },
    {
      title: '负责人',
      dataIndex: 'director',
      key: 'director',
    },
    {
      title: '创建时间',
      dataIndex: 'createTime',
      key: 'createTime',
      render: (text) => text ? new Date(text).toLocaleString() : '-',
    },
    {
      title: '操作',
      key: 'action',
      render: (_, record) => (
        <div>
          <Button 
            type="primary" 
            icon={<EditOutlined />} 
            style={{ marginRight: 8 }} 
            onClick={() => showEditModal(record)}
          >
            编辑
          </Button>
          <Popconfirm
            title="确定要删除这个实验室吗？"
            onConfirm={() => handleDelete(record.id)}
            okText="确定"
            cancelText="取消"
          >
            <Button 
              type="primary" 
              danger 
              icon={<DeleteOutlined />}
            >
              删除
            </Button>
          </Popconfirm>
        </div>
      ),
    },
  ];

  return (
    <div className="laboratory-management">
      <Card 
        title="实验室管理" 
        extra={
          <Button 
            type="primary" 
            icon={<PlusOutlined />} 
            onClick={showAddModal}
          >
            添加实验室
          </Button>
        }
      >
        <Table 
          columns={columns} 
          dataSource={laboratories} 
          rowKey="id" 
          loading={loading}
          pagination={{ pageSize: 10 }}
        />
      </Card>

      <Modal
        title={modalTitle}
        visible={modalVisible}
        onCancel={() => setModalVisible(false)}
        onOk={handleModalSubmit}
        okText="提交"
        cancelText="取消"
      >
        <Form
          form={form}
          layout="vertical"
        >
          <Form.Item
            name="name"
            label="实验室名称"
            rules={[{ required: true, message: '请输入实验室名称' }]}
          >
            <Input placeholder="请输入实验室名称" />
          </Form.Item>
          
          <Form.Item
            name="code"
            label="实验室代码"
            rules={[{ required: true, message: '请输入实验室代码' }]}
          >
            <Input placeholder="请输入实验室代码" />
          </Form.Item>
          
          <Form.Item
            name="director"
            label="负责人"
            rules={[{ required: true, message: '请输入负责人姓名' }]}
          >
            <Input placeholder="请输入负责人姓名" />
          </Form.Item>
          
          <Form.Item
            name="description"
            label="实验室描述"
          >
            <Input.TextArea rows={4} placeholder="请输入实验室描述" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default LaboratoryManagement;