From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 002/123] spi: uniphier: fix incorrect
 property items
Date: Wed, 5 Dec 2018 06:50:33 -0500
Message-ID: <20181205115033.GA1992@sasha-vm>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-2-sashal@kernel.org>
 <20181205113820.GB6205@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205113820.GB6205@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 05, 2018 at 11:38:20AM +0000, Mark Brown wrote:
>On Wed, Dec 05, 2018 at 04:33:54AM -0500, Sasha Levin wrote:
>> From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>>
>> [ Upstream commit 3511ba7d4ca6f39e2d060bb94e42a41ad1fee7bf ]
>>
>> This commit fixes incorrect property because it was different
>> from the actual.
>> The parameters of '#address-cells' and '#size-cells' were removed,
>> and 'interrupts', 'pinctrl-names' and 'pinctrl-0' were added.
>
>Not sure we should be backporting documentation changes like this to
>stable, especially not without accompanying code changes...

Dropped, thank you.
