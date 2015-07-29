From: Sifan Naeem <Sifan.Naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
 gpio_request_one
Date: Wed, 29 Jul 2015 12:43:06 +0000
Message-ID: <A0E307549471DA4DBAF2DE2DE6CBFB7E4966DA48@hhmail02.hh.imgtec.org>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
 <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
 <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw@mail.gmail.com>
 <20150727164015.GB11162@sirena.org.uk>
 <A0E307549471DA4DBAF2DE2DE6CBFB7E4966D9FF@hhmail02.hh.imgtec.org>
 <20150729122600.GB20130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Stable kernel (v4.1)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150729122600.GB20130-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> On Wed, Jul 29, 2015 at 11:05:05AM +0000, Sifan Naeem wrote:
> > Please find the new patch in
> > http://marc.info/?l=linux-spi&m=143816718611912&w=2
> >
> > Thanks,
> > Sifan
> >
> > > -----Original Message-----
> 
> Please don't top post and please submit patches using the normal process
> documented in SubmittingPatches.

Noted, I did submit the modified patch following the normal process, but as the patch title changed I mentioned it here.

[PATCH v2] spi: img-spfi: fix multiple calls to request gpio

Thanks,
Sifan 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
