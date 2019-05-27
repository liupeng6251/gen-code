package ${classInfo.packagePath}.core.page;

import com.google.common.collect.Lists;

import java.util.List;

/**
*
* Created by liupeng6251@163.com on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/

public class Pager<T> {
    private Pager.PageData page;
    private List<T> data;

    public Pager() {
    }
    public static <T> Pager.Builder<T> builder(List<T> data) {
        return (new Pager.Builder()).data(data);
    }

    public Pager(Pager.PageData page, List<T> data) {
        this.page = page;
        this.data = Lists.newArrayList();
        this.data.addAll(data);
    }
    public static class PageData {
        private static final long serialVersionUID = 3599580483667456581L;
        private int curPage;
        private int pageSize;
        private long totalSize;

        public PageData() {
        }


        public PageData(int curPage,int pageSize,long totalSize) {
            this.curPage = curPage;
            this.pageSize = pageSize;
            this.totalSize = totalSize;
        }

        public PageData(PageRequest.Page page, long totalSize) {
            if(page != null) {
                this.curPage = page.getCurrent();
                this.pageSize = page.getPageSize();
            }

            this.totalSize = totalSize;
        }

        public int getCurPage() {
            return this.curPage;
        }

        public boolean hasPreviousPage() {
            return this.getCurPage() > 1;
        }

        public boolean isFirstPage() {
            return !this.hasPreviousPage();
        }

        public int getPageSize() {
            return this.pageSize;
        }

        public long getTotalSize() {
            return this.totalSize;
        }

        public boolean hasNextPage() {
            return this.getCurPage() < this.getTotalPage();
        }

        public boolean isLastPage() {
            return !this.hasNextPage();
        }

        public int getTotalPage() {
            return this.getPageSize() == 0?1:(int)Math.ceil((double)this.totalSize / (double)this.getPageSize());
        }
    }
    public static class Builder<T> {
        private List<T> data;
        private PageRequest.Page page;
        private long totalSize;

        private Builder() {
            this.totalSize = 0;
        }

        public Pager.Builder<T> current(PageRequest.Page page) {
            this.page = page;
            return this;
        }

        public Pager.Builder<T> total(long totalSize) {
            this.totalSize = totalSize;
            return this;
        }

        public Pager.Builder<T> data(List<T> data) {
            this.data = data;
            return this;
        }

        public Pager<T> create() {
            return new Pager(new Pager.PageData(this.page, this.totalSize), this.data);
        }
    }
}