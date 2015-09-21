From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally incorrect DT binding
Date: Mon, 21 Sep 2015 20:06:31 +0200
Message-ID: <87bncvr6jc.fsf@belgarion.home>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
	<87zj0rsqhe.fsf@belgarion.home> <55FFB643.1080208@linux.intel.com>
	<87fv28qh49.fsf@belgarion.home> <20150921151503.GK2381@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Kevin Hilman <khilman@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	stable@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150921151503.GK2381@localhost> (Vinod Koul's message of "Mon,
	21 Sep 2015 20:45:03 +0530")
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Vinod Koul <vinod.koul@intel.com> writes:

>> Now knowing if it is v4.3-rc3 is another story, as currently the pxa platform is
>> broken because of a dmaengine regression. And if the necessary fix is not
>> applied through dmaengine tree (by lack of time from Vinod), I'll want to carry
>> it through my tree, which is the reason why I have not made the pull request
>> yet.
>
> Which ones are required for fixing, I will priortize those...
Hi Vinod,

My favorite (which fixes it fully) is :
 - https://lkml.org/lkml/2015/9/6/112 (ie. only 1/3)

As a fallback plan, if the above patch is too risky for a -rc serie, my fallback
plan is :
 - https://lkml.org/lkml/2015/9/21/128

PXA can sustain only the fallback for v4.3, but the favorite has to be in v4.4,
with its 2 other brothers, in a form or another. Fallback plan is compatible
with the favorite, ie. fallback should not be reverted after favorite is applied.

Cheers.

-- 
Robert
