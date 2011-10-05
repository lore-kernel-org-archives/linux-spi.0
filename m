From: "Tomoya MORINAGA" <Tomoya.Morinaga-nk68H3w8R80TBYAz+LHnZg@public.gmane.org>
Subject: RE: [GIT PULL] spi driver bug fixes
Date: Wed, 5 Oct 2011 13:44:21 +0900
Message-ID: <95F40BC8A9814963B7347EF0C1B3B50B__7666.18841230429$1317791382$gmane$org@hacdom.okisemi.com>
References: <CACxGe6uPnXm4Ehk0Bwss_B48j3oUtE1L8SSTyCE6nC2b9K0hhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Grant Likely'" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	"'Linus Torvalds'" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	"'Linux Kernel Mailing List'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<spi-devel-general@list
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6uPnXm4Ehk0Bwss_B48j3oUtE1L8SSTyCE6nC2b9K0hhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, October 05, 2011 1:15 AM, Grant Likely wrote:
> Tomoya, are these applicable for the stable tree?
Yes, these are applicable for the stable.

------
Tomoya
ROHM Co., Ltd.

-----Original Message-----
From: glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org [mailto:glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org] On Behalf Of Grant Likely
Sent: Wednesday, October 05, 2011 1:15 AM
To: Linus Torvalds; Linux Kernel Mailing List; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Tomoya
MORINAGA; stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Subject: [GIT PULL] spi driver bug fixes

Hi Linus,

Here are some bug fixes for the topcliff spi driver.

Tomoya, are these applicable for the stable tree?

The following changes since commit 0f86267b79bc6e357b8606077c7f70239045ea9c:

  Merge branch 'hwmon-for-linus' of git://github.com/groeck/linux
(2011-10-03 12:54:56 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi/merge

Tomoya MORINAGA (5):
      spi-topcliff-pch: add tx-memory clear after complete transmitting
      spi-topcliff-pch: Fix SSN Control issue
      spi-topcliff-pch: Fix CPU read complete condition issue
      spi-topcliff-pch: Add recovery processing in case FIFO overrun error occurs
      spi-topcliff-pch: Fix overrun issue

 drivers/spi/spi-topcliff-pch.c |   93 ++++++++++++++++++++++++++++------------
 1 files changed, 66 insertions(+), 27 deletions(-)


--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
