From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: On SPI bus locking API and mmc_spi
Date: Wed, 16 Jun 2010 12:56:02 -0600
Message-ID: <AANLkTim6WRYewPnHrNqfmC3FMyxzdiK8NEfgENuEQX6E@mail.gmail.com>
References: <20100610122442.880918bc.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100610122442.880918bc.ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 10, 2010 at 4:24 AM, Antonio Ospite
<ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:
> Hi,
>
> I would be interested to know about the status of the SPI bus locking
> API, especially related to mmc_spi, I see there is some discussion from
> February[1] mentioning a possible inclusion in 2.6.35[2], but I can't
> find the changes in mainline nor in the git tree here:
> http://git.secretlab.ca/?p=linux-2.6.git;a=shortlog;h=refs/heads/next-spi

The lead up to the .35 merge window was overloaded for me, so I never
picked it up.  I'll pick it up into my -next branch for testing in the
next week or so.

>
> I have a system (pxa27x based, a Motorola A910 smartphone) which has
> both the PMIC and the MMC on spi and I could test those patches if you
> recap where the latest versions are.

I'll send you the git tree url when I push it out.  Ping me early next
week if you don't hear from me otherwise.

g.

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
