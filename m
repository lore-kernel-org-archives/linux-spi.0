From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: mc13xxx core support for i2c
Date: Tue, 04 Jan 2011 01:01:50 +0000
Message-ID: <4D22717E.90003@fluff.org>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1292817055-17715-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 20/12/10 03:50, Marc Reilly wrote:
> These patches add i2c support for the mc13xxx-core driver. This v3 improves the v2
> (http://lists.arm.linux.org.uk/lurker/message/20101215.214755.b6bae366.en.html) by splitting
> the driver up into core, spi and i2c files so that it can support one subsystem in the absence
> of the other.

As noted by others, this needs to be re-worked so that the driver can
always been built and used across bisections.

A suggested approach would be to move items out into the header file
first, and then maybe split the spi driver out of the core, and then
add the I2c driver. It may also make the patch set easier to follow.
