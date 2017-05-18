package com.kantiana.skb.service;

import com.kantiana.skb.model.News;
import java.util.List;

public interface NewsService {
    public void save(News news);

    public List<News> getAllNews();

    public News findById(Long id);

    public void delete(Long newsId);

    public void delete(News news);


}
