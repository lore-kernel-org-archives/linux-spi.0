From: christian pellegrin <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -mm 0/1] max3100: Fixes for the MAX31x0
	console
Date: Thu, 8 Apr 2010 19:02:13 +0200
Message-ID: <g2qcabda6421004081002o97fec27fx1cc4640164930608__15041.7677280076$1270746170$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the problems reported by Feng Tang in the console
code. After this I intend to do a complete rework to apply the ideas
outlined by Grant Likely to avoid the use of delayed work and, if I
find a way, the batching of TX requests proposed by Feng Tang and Alan
Cox (I guess I will have at least to add a new function to the SPI
core to know the real bit/rate the system is using to make this work).
The relevant patches from the -mm kernel were tested on a 2.6.34-rc2
kernel on a S3C ARM machine. This patch ris based on them.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
