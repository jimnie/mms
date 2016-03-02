package com.educonsulting.mms;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/8.
 */
public class BranchNode extends TreeNode {

    //    一个节点数组声明了若干节点
    private List<TreeNode> children = new ArrayList<TreeNode>();

    public List<TreeNode> getChildren() {
        return children;
    }

    public void setChildren(List<TreeNode> children) {
        this.children = children;
    }
}
