From: Sunny Luo <sunny.luo@amlogic.com>
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Date: Thu, 13 Dec 2018 20:50:28 +0800
Message-ID: <cb02aadd-d317-fc66-de4a-519dc8d8bfb7@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
 <20181213115345.GC10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213115345.GC10669@sirena.org.uk>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark&Jerome,

On 2018/12/13 19:53, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 10:04:56AM +0100, Jerome Brunet wrote:
>> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
> 
>>>   
>>>   	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>>>   
>>> +	meson_spicc_oen_enable(spicc);
>>> +
> 
>> Any specific reason for doing this in prepare_message() ? It looks like
>> something that could/should be done during the probe ?
> 
> If it's for power management then there should be a matching disable in
> unprepare_message() (or this should just be in the runtime PM code,
> though it's possible there's stuff that's only needed while actually
> doing transfers in which case this could make sense).
> 
OEN is only used to avoid the signals floating in unexpected state, i 
will move it into probe next patch.

> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.
> 
OK.
