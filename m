From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Fri, 19 Jun 2015 12:02:22 +0200
Message-ID: <394B0003-AA2E-469F-AD9C-C291FAC60A94@martin.sperl.org>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org> <556EE446.3060407@metafoo.de> <20150603115319.GF14071@sirena.org.uk> <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org> <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org> <20150618134918.GF14071@sirena.org.uk> <20150619113539.04a7fcf2@north> <20150619095346.GG14071@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150619095346.GG14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 19.06.2015, at 11:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Fri, Jun 19, 2015 at 11:35:39AM +0200, Jakub Kici=C5=84ski wrote:
>=20
>> How about putting this file in debugfs after all?  Mark suggested it
>> initially but the conversation went in other direction.  Martin said
>> that his main purpose is to help *debugging* performance of RPi dma,
>> so it's a perfect candidate for debugfs.  I can't in my mind see any
>> use for this information on a production system to be honest...
>=20
> That's the solution I'd been expecting.

I got a patch in the meantime exposing the following files in
/sys/devices/platform/soc/20204000.spi/spi_master/spi32766/statistics/:
bytes
bytes_rx
bytes_tx
bytes_transfer_histo_0-1
bytes_transfer_histo_1024-2047
bytes_transfer_histo_128-255
bytes_transfer_histo_16-31
bytes_transfer_histo_16384-32767
bytes_transfer_histo_2048-4095
bytes_transfer_histo_2-3
bytes_transfer_histo_256-511
bytes_transfer_histo_32-63
bytes_transfer_histo_32768-65535
bytes_transfer_histo_4096-8191
bytes_transfer_histo_4-7
bytes_transfer_histo_512-1023
bytes_transfer_histo_64-127
bytes_transfer_histo_65536+
bytes_transfer_histo_8-15
bytes_transfer_histo_8192-16383
errors
messages
spi_async
spi_sync
spi_sync_immediate
timedout
transfers

You want me to move the bytes_transfer_histo_* now into debugfs instead=
?

If so then I would post a =E2=80=9Cbasic=E2=80=9D patch for the other s=
tatistics
and have debugfs for the histogram as a separate patch.

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
