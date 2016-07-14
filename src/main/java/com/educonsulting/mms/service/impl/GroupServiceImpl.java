package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.BranchNode;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.TreeNode;
import com.educonsulting.mms.dao.GroupDao;
import com.educonsulting.mms.entity.Group;
import com.educonsulting.mms.service.GroupService;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/7.
 */
@Service("groupServiceImpl")
public class GroupServiceImpl extends BaseServiceImpl<Group, Long> implements GroupService {

    @Resource(name = "groupDaoImpl")
    private GroupDao groupDao;

    @Resource(name = "groupDaoImpl")
    public void setBaseDao(GroupDao groupDao) {
        super.setBaseDao(groupDao);
    }

    @Cacheable(value = "group")
    public Group findRoot() {
        return groupDao.findRoot();
    }

    public Object getTree() {
        Group group = groupDao.findRoot();
        List<TreeNode> nodes = new ArrayList<TreeNode>();
        nodes.add(createNode(group));
        return nodes;
    }

    @Transactional(readOnly = true)
    public boolean isTagNameExists(String tag) {
        return groupDao.isTagNameExists(tag);
    }

    /**
     * 取得树节点list
     *
     * @param groups
     * @return
     */
    private List<TreeNode> getTreeNodes(List<Group> groups) {
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        for (Group group : groups) {
            nodeList.add(createNode(group));
        }
        return nodeList;
    }

    /**
     * 构建节点
     *
     * @param group
     * @return
     */
    private TreeNode createNode(Group group) {
        if (CollectionUtils.isNotEmpty(group.getChildren())) {
            return createBranchNode(group);
        } else {
            return createTreeNode(group);
        }
    }

    /**
     * 构建叶节点
     *
     * @param group
     * @return
     */
    private TreeNode createTreeNode(Group group) {
        TreeNode node = new TreeNode();
        node.setId(String.valueOf(group.getId()));
        node.setText(group.getName());
        node.setAttributes(group);
        return node;
    }

    public Group findGroup(String id) {
        Group root = groupDao.findRoot();
        for (Group group : root.getChildren()) {
            if (group.getId().equals(id)) {
                return group;
            }
        }
        return null;
    }

    /**
     * 构建分支节点
     *
     * @param group
     * @return
     */
    private BranchNode createBranchNode(Group group) {
        BranchNode node = new BranchNode();
        node.setState(group.getNodeState());
        node.setChecked(Boolean.FALSE);
        node.setChildren(getTreeNodes(group.getChildren()));
        node.setId(String.valueOf(group.getId()));
        node.setText(group.getName());
        node.setAttributes(group);
        return node;
    }

    @Override
    public Group find(Long id) {
        return super.find(id);
    }

    @Override
    @Cacheable(value = "group")
    public List<Group> findAll() {
        return super.findAll();
    }

    @Override
    @Cacheable(value = "group")
    public Page<Group> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public void save(Group entity) {
        super.save(entity);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public Group update(Group entity) {
        return super.update(entity);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public Group update(Group entity, String... ignoreProperties) {
        return super.update(entity, ignoreProperties);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public void delete(Long id) {
        super.delete(id);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public void delete(Long... ids) {
        super.delete(ids);
    }

    @Override
    @CacheEvict(value = "group", allEntries = true)
    public void delete(Group entity) {
        super.delete(entity);
    }
}
