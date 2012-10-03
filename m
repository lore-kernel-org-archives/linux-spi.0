From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
Date: Wed, 3 Oct 2012 15:29:14 +0100
Message-ID: <20121003142913.GF4360@opensource.wolfsonmicro.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
	<1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
	<CAPDyKFo5-UeUe7PkxCBMnRziWh+eSC_ZjJ0pKhcBkHUkFdSH+w@mail.gmail.com>
	<20121003135556.GE4360@opensource.wolfsonmicro.com>
	<CAPDyKFrQ9UhEc_jEKdR=J8T-NUxsYQHB-yMh2vTyxJ+y+R38Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrQ9UhEc_jEKdR=J8T-NUxsYQHB-yMh2vTyxJ+y+R38Og-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 03, 2012 at 04:28:34PM +0200, Ulf Hansson wrote:

> I will do a resend and include some explanation for the reverts in the
> "cover-letter".

It'd be good if the explanation could be in the commit logs so that
people reading history can understand things.

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
