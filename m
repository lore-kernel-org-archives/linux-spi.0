From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mtd: spi-nor: Correct device-id for n25q512a device
Date: Tue, 29 Jul 2014 21:26:20 -0700
Message-ID: <CAN8TOE9mA_XA2jgTNEofssy=4fL9RcKaKSRBhdJt54K0n7P3cw@mail.gmail.com>
References: <1404795285-2929-1-git-send-email-Priyanka.Jain@freescale.com>
	<CAMuHMdV52qwThCezu=4NCpVBwbM2AjSK4cKXA+BdO=v_Yy2sBQ@mail.gmail.com>
	<20140730041431.GD11952@brian-ubuntu>
	<40bf530c679d46a4a0a73d3d22484f7c@CY1PR0301MB0857.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Priyanka Jain <Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <40bf530c679d46a4a0a73d3d22484f7c-YrwGdl+Pljm9QR8CEcd8AJwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jul 29, 2014 at 9:17 PM, Priyanka Jain
<Priyanka.Jain-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Should I send another patch which just add
>> > > +       { "n25q512a",    INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K) },
> And let the original one as it is ?

No. We already have this entry queued up for 3.17:

+       { "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, USE_FSR) },

Feel free to test it out.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
