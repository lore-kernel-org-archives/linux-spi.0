From: Christian Pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>
Subject: [PATCH 1/3] max3100: added raise_threaded_irq
Date: Fri, 19 Mar 2010 09:38:54 +0100
Message-ID: <1268987934-22690-1-git-send-email-chripell@fsfe.org>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Christian Pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>
To: feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org,
	david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <cabda6421003190139h344bc172h3556fca78e4b25cb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

raise_threaded_irq schedules the execution of an interrupt thread

Signed-off-by: Christian Pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>
---
 include/linux/interrupt.h |    3 +++
 kernel/irq/manage.c       |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 75f3f00..14c0c13 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -144,6 +144,9 @@ request_threaded_irq(unsigned int irq, irq_handler_t handler,
 static inline void exit_irq_thread(void) { }
 #endif
 
+extern int raise_threaded_irq(unsigned int irq);
+
+
 extern void free_irq(unsigned int, void *);
 
 struct device;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index eb6078c..a7d21e0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1088,3 +1088,30 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	return retval;
 }
 EXPORT_SYMBOL(request_threaded_irq);
+
+/**
+ *	raise_threaded_irq - triggers a threded interrupt
+ *	@irq: Interrupt line to trigger
+ */
+int raise_threaded_irq(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action;
+
+	if (!desc)
+		return -ENOENT;
+	action = desc->action;
+	if (!action)
+		return -ENOENT;
+	if (unlikely(!action->thread_fn))
+		return -EINVAL;
+	if (likely(!test_bit(IRQTF_DIED,
+			     &action->thread_flags))) {
+		set_bit(IRQTF_RUNTHREAD, &action->thread_flags);
+		wake_up_process(action->thread);
+	} else {
+		return -ECHILD;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(raise_threaded_irq);
-- 
1.5.6.5


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
