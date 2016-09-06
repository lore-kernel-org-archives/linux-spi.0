From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 04/18] spi: fsl-espi: pre-allocate message buffer
Date: Tue, 6 Sep 2016 22:57:49 +0200
Message-ID: <f895014d-e8d6-9917-47a6-12f37b798b86@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
 <cabc3522-8ca9-516a-e0ef-5a2ed9ad8507@gmail.com>
 <0e60b4b5-5016-e1c3-d29d-b81a41f64f48@gmail.com>
 <20160906105833.GL3950@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160906105833.GL3950-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 06.09.2016 um 12:58 schrieb Mark Brown:
> On Sun, Sep 04, 2016 at 09:58:02AM +0200, Heiner Kallweit wrote:
>> Currently the driver allocates a 64kb buffer with each single message.
>> On systems with little and fragmented memory this can result in
>> memory allocation errors. Solve this by pre-allocating a buffer.
>>
>> This patch was developed in OpenWRT long ago, however it never
>> made it upstream. Author: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
>>
>> I slightly modified the original patch to re-initialize the buffer
>> at the beginning of each transfer.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> When you sent this previously I asked what happened with the signoff
> from Gabor.  A little Google tells me that he did in fact sign off the
> copy that's in OpenWRT.  Please don't drop signoffs, they're important
> for tracking licensing - see SubmittingPatches for details.  If the
> modifications you made really are slight as you say then I'd also expect
> Gabor's authorship to be preserved.
> 
Sorry, then I misunderstood your comment.
I'll resend the patch with Gabor's Signed-off-by. Do you want my
Signed-off-by in addition?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
