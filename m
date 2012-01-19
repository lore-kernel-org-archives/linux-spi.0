From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: mc13xxx: add I2C support
Date: Thu, 19 Jan 2012 11:29:41 +0000
Message-ID: <20120119112941.GC29494@sirena.org.uk>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <87lip4kktc.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87lip4kktc.fsf-0gaJ4kiyQU6khWr4QmshqB2eb7JE58TQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 19, 2012 at 12:12:31PM +0100, Arnaud Patard wrote:

> I've never looked at regmap deeply but can't it be done with regmap or is it
> just a bad idea ?

Glancing quickly at the existing code it should map on reasonably well,
though a new format definition may be required for the 25 bit shift that
would be trivial.
