From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] Check flag status register for Micron n25q512a
Date: Sat, 1 Mar 2014 20:04:22 +0100
Message-ID: <201403012004.22436.marex@denx.de>
References: <6bf927e513554e628fe15d309aac698e@BLUPR07MB002.namprd07.prod.outlook.com> <20140227073314.GD13420@norris-Latitude-E6410> <d695e8d34cac47608353f858d51c3e59@BY2PR07MB011.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Insop Song <Insop.Song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d695e8d34cac47608353f858d51c3e59-Rl8gF8DaO8TbI3BPuG3eVRQPvRvOrrxkXA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday, March 01, 2014 at 03:00:04 AM, Insop Song wrote:
> Hi Brian,
> 
> Thank you for your feedback.
> 
> > From: Brian Norris [mailto:computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > Sent: Wednesday, February 26, 2014 11:33 PM>
> > 
> > On Mon, Jan 06, 2014 at 05:21:17AM +0000, Insop Song wrote:
> > > In order to use Micron n25q512a, MTD, two changes are required as
> > 
> > follows:
> > > - jedec code should be fixed
> > 
> > I have a feeling there are more than one "n25q512a" device, with
> > different IDs.
> > 
> > > - flag status should be read for writing.
> > > 
> > > Check flag status register for Micron n25q512a
> > > 
> > >     - Programing Micron n25q512a requires to check flag status register
> > >     - According to datasheet
> > >     
> > >     	"
> > >     	The flag status register must be read any time a PROGRAM, ERASE,
> > >     	SUSPEND/RESUME command is issued, or after a RESET command
> > 
> > while device
> > 
> > >     	is busy. The cycle is not complete until bit 7 of the flag 
status
> > >     	register output 1.
> > >     	"
> > >     
> > >     - Ref:
> > https://www.micron.com/~/media/Documents/Products/Data%20Sheet/N
> > OR%20F
> > 
> > > lash/Serial%20NOR/N25Q/n25q_512mb_1ce_3v_65nm.pdf
> > 
> > Hmm, are you sure that all Micron n25q512a need to check the flag status
> > register? I'll check my datasheets when I'm back in the office, but this
> > seems peculiar.
> 
> "Flag status" term can be found in 84 time in the data sheet and I don't
> think the flag status is specific to particular type of n25q512a.

n25q256a works just fine with regular SR check.

[...]

> > > @@ -782,7 +864,7 @@ static const struct spi_device_id m25p_ids[] = {
> > > 
> > >  	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
> > >  	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
> > >  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
> > > 
> > > -	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
> > > +	{ "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },
> > 
> > You probably want to figure out the distinction between the old table
> > entry and the new one, and assign your new entry a new string
> > accordingly.
> 
> You mean "0x20bb20" (old value) must be still the valid value?

Likely, since someone added it before and if you look at the other Micron 
entries, you see chips with '0x20bb..' as well as '0x20ba' . Micron must have 
done something funny here (again :-( )
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
