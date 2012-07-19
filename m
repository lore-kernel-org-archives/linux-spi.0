From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHSET] kthread_worker: reimplement flush_kthread_work() to
	allow freeing during execution
Date: Thu, 19 Jul 2012 14:15:10 -0700
Message-ID: <20120719211510.GA32763@google.com>
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
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

kthread_worker was introduced together with concurrency managed
workqueue to serve workqueue users which need a special dedicated
worker - e.g. RT scheduling.  This is minimal queue / flush / flush
all iterface on top of kthread and each provided interface matches the
workqueue counterpart so that switching isn't difficult.

However, one noticeable difference was that kthread_worker doesn't
allow a work item to be freed while being executed.  The intention was
to keep the code simpler but it didn't really and the restriction is
subtle and does prevent some valid use cases.

This two-patch series reimplements flush_kthread_work() so that it
uses an extra work item for flushing.  While this takes a bit more
lines, this is easier to understand and removes the annoying
difference.

This patchset contains the following two patches.

 0001-kthread_worker-reorganize-to-prepare-for-flush_kthre.patch
 0002-kthread_worker-reimplement-flush_kthread_work-to-all.patch

The first one is a prep patch which makes no functional changes.  The
second reimplements flush_kthread_work().

All current kthread_worker users are cc'd.  If no one objects, I'll
push it through the workqueue branch.  This patchset is also available
in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git review-kthread_worker-flush

diffstat follows.  Thanks.

 include/linux/kthread.h |    8 +---
 kernel/kthread.c        |   86 +++++++++++++++++++++++++++---------------------
 2 files changed, 52 insertions(+), 42 deletions(-)

-- 
tejun

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
