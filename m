From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 0/3] spi/bcm63xx: drivers cleanups and fix
Date: Thu, 28 Jun 2012 00:26:50 +0200
Message-ID: <2386370.uiDYT7JcGi@bender>
References: <1337619960-9672-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1337619960-9672-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
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

FlorianOn Monday 21 May 2012 19:05:57  Fainelli wrote:
> Hi Grant,
> 
> These are 3 cleanups and fixes based on your spi/merge branch. I hope this
> is not too later for the 3.4-rc cycle.

You told me you applied these patches, where can I find them applied and pushed 
out? They do not seem to show up in your spi/merge nor spi/next branches at 
git.secretlab.ca

Thanks!

> 
> Florian Fainelli (3):
>   spi/bcm63xx: remove driver version
>   spi/bcm63xx: add missing spi_master_{resume,suspend} calls to PM
>     callbacks
>   spi/bcm63xx: remove useless call to bcm63xx_spi_check_transfer()
> 
>  drivers/spi/spi-bcm63xx.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> 
-- 
Florian

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
