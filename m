From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] spi: mediatek: fix wrong error return value on probe
Date: Tue, 15 Sep 2015 13:49:11 +0200
Message-ID: <55F805B7.7020706@osg.samsung.com>
References: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
 <20150914183925.GG12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150914183925.GG12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Mark,

On 09/14/2015 08:39 PM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 12:50:56AM +0200, Javier Martinez Canillas wrote:
>> Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
>> added a new sel_clk but introduced bugs in the error paths since
>> the wrong struct clk pointers are passed to PTR_ERR().
> 
> This doesn't apply against current code, please check and resend.
> 

Which branch should I use as a baseline then? The patch applies cleanly
on both today's linux-next (next-20150915) and your for-linus branch:

https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=for-linus

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
