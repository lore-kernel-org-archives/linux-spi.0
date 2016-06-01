From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Wed, 1 Jun 2016 09:58:22 +0800
Message-ID: <574E413E.7060909@gtsys.com.hk>
References: <574D5C2B.1000400@gtsys.com.hk>
 <20160531130828.GB29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160531130828.GB29837-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

On Tuesday, May 31, 2016 09:08 PM, Mark Brown wrote:
> On Tue, May 31, 2016 at 05:40:59PM +0800, Chris Ruehl wrote:
>> Hi,
>>
>> as imx6 using multiple burst to send data to spi slaves and drop the
>> chipselect between the words by default my sensor NXP MPL115A1 wasn't
>> working.
>
> Please submit patches in the format covered in SubmittingPatches, I
> can't take anything without a Signed-off-by.
>

Thanks,
  I will do submit an 'offical" patch with the input's from the
ongoing discussion. I'm on a change enable the single-burst-mode let
the cs_change alone.
I set a mask in the bit_per_word to enable it, which keeps changes in
the spi-imx.c only.

Chris



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
