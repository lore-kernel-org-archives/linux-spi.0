From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] kthread_worker: reorganize to prepare for
	flush_kthread_work() reimplementation
Date: Thu, 19 Jul 2012 14:15:41 -0700
Message-ID: <20120719211541.GB32763@google.com>
References: <20120719211510.GA32763@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	ivtv-devel-jGorlIydJmRM656bX5wj8A@public.gmane.org, Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120719211510.GA32763-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>From c9bba34243a86fb3ac82d1bdd0ce4bf796b79559 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Thu, 19 Jul 2012 13:52:53 -0700

Make the following two non-functional changes.

* Separate out insert_kthread_work() from queue_kthread_work().

* Relocate struct kthread_flush_work and kthread_flush_work_fn()
  definitions above flush_kthread_work().

Signed-off-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 kernel/kthread.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3d3de63..7b8a678 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -378,6 +378,17 @@ repeat:
 }
 EXPORT_SYMBOL_GPL(kthread_worker_fn);
 
+/* insert @work before @pos in @worker */
+static void insert_kthread_work(struct kthread_worker *worker,
+			       struct kthread_work *work,
+			       struct list_head *pos)
+{
+	list_add_tail(&work->node, pos);
+	work->queue_seq++;
+	if (likely(worker->task))
+		wake_up_process(worker->task);
+}
+
 /**
  * queue_kthread_work - queue a kthread_work
  * @worker: target kthread_worker
@@ -395,10 +406,7 @@ bool queue_kthread_work(struct kthread_worker *worker,
 
 	spin_lock_irqsave(&worker->lock, flags);
 	if (list_empty(&work->node)) {
-		list_add_tail(&work->node, &worker->work_list);
-		work->queue_seq++;
-		if (likely(worker->task))
-			wake_up_process(worker->task);
+		insert_kthread_work(worker, work, &worker->work_list);
 		ret = true;
 	}
 	spin_unlock_irqrestore(&worker->lock, flags);
@@ -406,6 +414,18 @@ bool queue_kthread_work(struct kthread_worker *worker,
 }
 EXPORT_SYMBOL_GPL(queue_kthread_work);
 
+struct kthread_flush_work {
+	struct kthread_work	work;
+	struct completion	done;
+};
+
+static void kthread_flush_work_fn(struct kthread_work *work)
+{
+	struct kthread_flush_work *fwork =
+		container_of(work, struct kthread_flush_work, work);
+	complete(&fwork->done);
+}
+
 /**
  * flush_kthread_work - flush a kthread_work
  * @work: work to flush
@@ -436,18 +456,6 @@ void flush_kthread_work(struct kthread_work *work)
 }
 EXPORT_SYMBOL_GPL(flush_kthread_work);
 
-struct kthread_flush_work {
-	struct kthread_work	work;
-	struct completion	done;
-};
-
-static void kthread_flush_work_fn(struct kthread_work *work)
-{
-	struct kthread_flush_work *fwork =
-		container_of(work, struct kthread_flush_work, work);
-	complete(&fwork->done);
-}
-
 /**
  * flush_kthread_worker - flush all current works on a kthread_worker
  * @worker: worker to flush
-- 
1.7.7.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
