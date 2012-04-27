From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: bcm63xx fixes
Date: Fri, 27 Apr 2012 15:10:31 +0200
Message-ID: <3699714.O3MZhDn1pX@flexo>
References: <1334929056-1598-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334929056-1598-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Friday 20 April 2012 15:37:32 Florian Fainelli wrote:
> Hi Grant,
> 
> This patch series aims at fixing the spi-bcm63xx driver which is currently
> sleeping in its transfer() function. This series is aimed at 3.4-rcX.

Any update on these patches? Thanks!

> 
> Thanks!
> 
> Florian Fainelli (4):
>   spi: bcm63xx: convert to the pump message infrastructure
>   spi: bcm63xx: don't use the stopping state
>   spi: bcm63xx: set master driver mode_bits.
>   spi: bcm63xx: bump driver version to 0.1.3.
> 
>  drivers/spi/spi-bcm63xx.c |  165
> +++++++++++++++++++++++++-------------------- 1 files changed, 93
> insertions(+), 72 deletions(-)
--
Florian

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
