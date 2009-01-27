From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Move eeprom drivers to drivers/misc/eeprom
Date: Tue, 27 Jan 2009 09:04:42 +0100
Message-ID: <20090127090442.35190667@hyperion.delvare>
References: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de>
	<200901262355.27913.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200901262355.27913.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 26 Jan 2009 23:55:27 -0800, David Brownell wrote:
> On Tuesday 20 January 2009, Wolfram Sang wrote:
> > This patch series carries out the proposal and while at it, moves an
> > eeprom driver which was already in drivers/misc to the new location.
> > 
> > No code inside the drivers was changed and everything was
> > succesfully compile-tested.
> 
> Now that thhis is in mainline ... I suggest two more changes:
> 
>  - at24 (i2c eeprom) doesn't need to be EXPERIMENTAL
> 
>  - we still need interfaces whereby kernel code can be
>    given handles to the EEPROM devices, and then use
>    them to read board config data out during boot.
> 
> Obviously, the first one is easy.  ;)

Indeed, but where's the patch?

Oh, and thank you for volunteering to maintain the eeprom drivers ;)

-- 
Jean Delvare
