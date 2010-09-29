From: Jate Sujjavanich <jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>
Subject: RE: [uClinux-dev] [PATCH] m68knommu: Coldfire QSPI platform support
Date: Wed, 29 Sep 2010 09:44:32 -0400
Message-ID: <6C2434209962DC46B88345CA85C334A2A434E65AF7@Courier.syntech.org>
References: <201001221243.04045.sfking@fdwdc.com>
	<4C4FA5AA.3020804@snapgear.com>
	<6C2434209962DC46B88345CA85C334A2A434E65ADC@Courier.syntech.org>
	<201009230842.40958.sfking@fdwdc.com>
	<6C2434209962DC46B88345CA85C334A2A434E65AEA@Courier.syntech.org>
	<4CA17F2D.7000407@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	'Greg Ungerer' <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>
To: 'Steven King' <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4CA17F2D.7000407-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Here's a patch for your review.


After grabbing a msg from the msgq, the mcfqspi_work function calls
list_del_init on the mcfqspi->msgq which unintentionally deletes the rest
of the list before it can be processed. If qspi call was made using
spi_sync, this can result in a process hang.

Signed-off by Jate Sujjavanich<jsujjavanich-oI4RZb1+6EReLsYL91UIxL5dPsmED6B0@public.gmane.org>
-----------
diff --git a/drivers/spi/coldfire_qspi.c b/drivers/spi/coldfire_qspi.c
index 59be3ef..0aa00af 100644
--- a/drivers/spi/coldfire_qspi.c
+++ b/drivers/spi/coldfire_qspi.c
@@ -316,7 +316,7 @@ static void mcfqspi_work(struct work_struct *work)
                 msg = container_of(mcfqspi->msgq.next, struct spi_message,
                                    queue);
-               list_del_init(&mcfqspi->msgq);
+               list_del_init(&msg->queue);
                 spin_unlock_irqrestore(&mcfqspi->lock, flags);
                 spi = msg->spi;

-----Original Message-----
From: Greg Ungerer [mailto:gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org] 
Sent: Tuesday, September 28, 2010 1:38 AM
To: Jate Sujjavanich
Cc: 'Steven King'; uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Subject: Re: [uClinux-dev] [PATCH] m68knommu: Coldfire QSPI platform support

Hi Jate,

On 25/09/10 00:00, Jate Sujjavanich wrote:
> I tried out the&msg->queue, and it's running fine. It's better than my fix because it's more clear than "mcfqspi->msgq.next".
>
>
> <SNIP>

Seeing as this is spi related you should send this to the spi
list as well (or at least to Grant Likley as well).

Regards
Greg






------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
