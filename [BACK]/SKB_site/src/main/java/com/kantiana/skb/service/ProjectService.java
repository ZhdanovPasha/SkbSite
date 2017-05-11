package com.kantiana.skb.service;

import com.kantiana.skb.model.Project;

import java.util.List;

public interface ProjectService {
    public void save(Project project);

    public Project findByName(String name);

    public List<Project> getAllProjects();
}
