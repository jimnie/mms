package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.*;
import com.educonsulting.mms.dao.ResourceDao;
import com.educonsulting.mms.entity.Resources;
import com.educonsulting.mms.service.ResourceService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/12.
 */
@Service("resourceServiceImpl")
public class ResourceServiceImpl extends BaseServiceImpl<Resources, String> implements
        ResourceService {

    @Resource(name = "resourceDaoImpl")
    private ResourceDao resourceDao;

    @Resource(name = "resourceDaoImpl")
    public void setBaseDao(ResourceDao resourceDao) {
        super.setBaseDao(resourceDao);
    }

    @Override
    public Object getTree() {
        Resources resource = resourceDao.find(CommonAttributes.RESOURCE_ROOT_ID);
        List<TreeNode> nodes = new ArrayList<TreeNode>();
        nodes.add(createNode(resource));
        return nodes;
    }

    @Transactional
    public boolean isAliasNameExists(String aliasName) {
        return resourceDao.isAliasNameExists(aliasName);
    }

    @Override
    public Resources findSubnodes(String id) {
        return resourceDao.findSubnodes(id);
    }

    @Override
    public Resources findParents() {
        return resourceDao.findParents();
    }

    @Override
    public Resources find(String id) {
        return super.find(id);
    }

    @Override
    public List<Resources> findAll() {
        return super.findAll();
    }

    @Override
    public Page<Resources> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    /**
     * 取得树节点list
     *
     * @param list
     * @return
     */
    private List<TreeNode> getTreeNodes(List<Resources> list) {
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        for (Resources resource : list) {
            nodeList.add(createNode(resource));
        }
        return nodeList;
    }

    /**
     * 构建节点
     *
     * @param resource
     * @return
     */
    private TreeNode createNode(Resources resource) {
        if (CollectionUtils.isNotEmpty(resource.getChildren())) {
            return createBranchNode(resource);
        } else {
            return createLeafNode(resource);
        }
    }

    /**
     * 构建叶节点
     *
     * @param resource
     * @return
     */
    private TreeNode createLeafNode(Resources resource) {
        TreeNode node = new TreeNode();
        node.setId(String.valueOf(resource.getId()));
        node.setText(resource.getText());
        node.setChecked(Boolean.FALSE);
        node.setAttributes(resource);
        return node;
    }

    /**
     * 构建分支节点
     *
     * @param resource
     * @return
     */
    private BranchNode createBranchNode(Resources resource) {
        BranchNode node = new BranchNode();
        node.setState(resource.getState());
        node.setChildren(getTreeNodes(resource.getChildren()));
        node.setId(String.valueOf(resource.getId()));
        node.setText(resource.getText());
        node.setChecked(Boolean.FALSE);
        node.setAttributes(resource);
        return node;
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public void save(Resources entity) {
        super.save(entity);
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public Resources update(Resources entity) {
        return super.update(entity);
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public Resources update(Resources entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public void delete(String id) {
        super.delete(id);
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Override
    @CacheEvict(value = "resource", allEntries = true)
    public void delete(Resources entity) {
        super.delete(entity);
    }
}
