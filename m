From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 04/18] spi: fsl-espi: pre-allocate message buffer
Date: Wed, 7 Sep 2016 22:01:10 +0200
Message-ID: <2e735147-7a3f-0b08-dba9-bbca2a01cdc6@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
 <14371aa8-17f2-69a2-99d4-cd095a87545c@gmail.com>
 <20160907185614.GD3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160907185614.GD3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 07.09.2016 um 20:56 schrieb Mark Brown:
> On Wed, Sep 07, 2016 at 07:46:33AM +0200, Heiner Kallweit wrote:
>> Currently the driver allocates a 64kb buffer for each single message.
>> On systems with little and fragmented memory this can result in
>> memory allocation errors. Solve this by pre-allocating a buffer.
> 
> This is flagged as patch 4/18 but I only have this as a single patch.
> As previously discussed the purpose of the numbering in a patch series
> is to order things, if you're just sending a single patch it doesn't
> need numbering and if you're sending a series you need to send either
> the whole thing or at least a cover letter to everyone so they know
> what's going on.
> 
OK, as you applied three further patches from the series already, I'll
resend the remaining 15 with new numbering.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
