From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] spi: add support for SuperH SPI
Date: Wed, 16 Feb 2011 17:09:58 +0900
Message-ID: <4D5B8656.8090901@renesas.com>
References: <4D59D738.4070304@renesas.com>
 <20110216025950.GM28005@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <20110216025950.GM28005@angua.secretlab.ca>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2011/02/16 11:59, Grant Likely wrote:
> On Tue, Feb 15, 2011 at 10:30:32AM +0900, Yoshihiro Shimoda wrote:
>> The SH7757 has SPI0 module. This patch supports it.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Merged, thanks.  I made a few minor edits on style issues and to add
> the __devinit/__devexit annotations to the probe/remove functions.
> Please give it a spin to make sure I haven't broken anything when it
> appears in my spi/next branch on git://git.secretlab.ca/git/linux-2.6
> (sometime in the next 6 hours).

Thank you very much!
I confirmed that the merged patch works correctly.

Thanks,
Yoshihiro Shimoda

> g.
> 
