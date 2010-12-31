From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 15/15]drivers:spi:dw_spi.c Typo change diable to disable.
Date: Thu, 30 Dec 2010 22:38:44 -0800
Message-ID: <4D1D7A74.3030803__33808.5027215586$1293777584$gmane$org@gmail.com>
References: <1293750484-1161-6-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-7-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-8-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-9-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-10-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-11-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-12-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-13-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-14-git-send-email-justinmattock@gmail.com>
	<1293750484-1161-15-git-send-email-justinmattock@gmail.com>
	<20101231063433.GB1886@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <error27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-wireless@vge
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101231063433.GB1886@bicker>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/30/2010 10:34 PM, Dan Carpenter wrote:
> On Thu, Dec 30, 2010 at 03:08:04PM -0800, Justin P. Mattock wrote:
>> The below patch fixes a typo "diable" to "disable". Please let me know if this
>> is correct or not.
>>
>> Signed-off-by: Justin P. Mattock<justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> ---
>>   drivers/spi/dw_spi.c |    6 +++---
>
> You missed one from this file:
>
> /* Set the interrupt mask, for poll mode just diable all int */
>                                                ^^^^^^
> regards,
> dan carpenter
>
>

oh-man... my grepping wasn't so grepping after all.. thanks for that 
I'll resend this one

Justin P. Mattock

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
