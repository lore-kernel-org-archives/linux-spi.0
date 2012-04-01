From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: Re: mc13xxx: add I2C support, V5
Date: Sun, 1 Apr 2012 19:39:49 +1000
Message-ID: <201204011939.49665.marc@cpdesign.com.au>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
	<20120401092125.GX15647@pengutronix.de>
Reply-To: marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, alexg-uRCCPK1wpQlR0G4FFNCX/g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120401092125.GX15647-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Uwe,


> On Sun, Apr 01, 2012 at 04:41:35PM +1000, Marc Reilly wrote:
> > This series (against mfd-2.6/for-next) changes the mc13xxx driver to use
> > regmap and adds I2C support.
> > It has a compile dependency on regmap/for-next, as the spi driver uses
> > the recently added pad_bits config field.
> > 
> > Patch 2/4 has:
> > Reviewed-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > Patch 4/4 has:
> > Signed-off-by: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
> 
> You didn't add these tags to the respective patches. (And I think
> Signed-off-by: Oskar is wrong. Maybe this should be an Ack?)

Whats the best/proper way to do this? Do I need to rebase the series and add 
them with each relevant commit, or just add them manually to the patches? Or 
option C...

For Oskar's tag, I just copied it from an email from the previous thread. 

Cheers,
Marc 

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
