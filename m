From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: fix spi.h kernel-doc warning
Date: Fri, 27 Apr 2012 11:03:47 -0600
Message-ID: <20120427170347.BEA843E0B4D@localhost>
References: <4F8E04E6.60005@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4F8E04E6.60005-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 17 Apr 2012 17:03:50 -0700, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org> wrote:
> From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> 
> Fix kernel-doc warning in spi.h (copy/pasto):
> 
> Warning(include/linux/spi/spi.h:365): No description found for parameter 'unprepare_transfer_hardware'
> 
> Signed-off-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  include/linux/spi/spi.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-34-rc3.orig/include/linux/spi/spi.h
> +++ lnx-34-rc3/include/linux/spi/spi.h
> @@ -254,7 +254,7 @@ static inline void spi_unregister_driver
>   *	driver is finished with this message, it must call
>   *	spi_finalize_current_message() so the subsystem can issue the next
>   *	transfer
> - * @prepare_transfer_hardware: there are currently no more messages on the
> + * @unprepare_transfer_hardware: there are currently no more messages on the
>   *	queue so the subsystem notifies the driver that it may relax the
>   *	hardware by issuing this call
>   *

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
