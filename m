From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally incorrect DT binding
Date: Mon, 21 Sep 2015 11:03:18 +0200
Message-ID: <87fv28qh49.fsf@belgarion.home>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
	<87zj0rsqhe.fsf@belgarion.home> <55FFB643.1080208@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	stable@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Kevin Hilman <khilman@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <55FFB643.1080208@linux.intel.com> (Jarkko Nikula's message of
	"Mon, 21 Sep 2015 10:48:19 +0300")
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:

> Hi
>
> On 09/12/2015 04:43 PM, Robert Jarzmik wrote:
>> Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:
>>
>>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
>>> build error here because it removed the type LPSS_SSP and I didn't notice
>>> the type was used here too.
>> Queued into pxa/fixes, thanks.
>>
> Gentle reminder, is this going to 4.3-rc3?
It is going into v4.3.

Now knowing if it is v4.3-rc3 is another story, as currently the pxa platform is
broken because of a dmaengine regression. And if the necessary fix is not
applied through dmaengine tree (by lack of time from Vinod), I'll want to carry
it through my tree, which is the reason why I have not made the pull request
yet.

Cheers.

-- 
Robert
