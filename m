From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: mc13xxx: add I2C support, V5
Date: Tue, 1 May 2012 12:39:49 +0200
Message-ID: <20120501103949.GC20224@sortiz-mobl>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
 <201204170921.42027.marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204170921.42027.marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Marc,

On Tue, Apr 17, 2012 at 09:21:41AM +1000, Marc Reilly wrote:
> Hi Samuel,
> 
> 
> On Sunday, April 01, 2012 04:41:35 PM Marc Reilly wrote:
> > This series (against mfd-2.6/for-next) changes the mc13xxx driver to use
> > regmap and adds I2C support.
> > It has a compile dependency on regmap/for-next, as the spi driver uses the
> > recently added pad_bits config field.
> 
> (bump).
> 
> Are these changes OK to go in?
All 4 patches applied to my for-next branch.
I had to manually apply patch #1, please verify that it's all good.
I added an Acked-by: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org> to patch #4. Please make
sure that you add the right tags to the corresponding patches in the future.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
