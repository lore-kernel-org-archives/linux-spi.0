From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: Re: [PATCH 3/3] spi: qup: Remove .owner field for driver
Date: Tue, 14 Oct 2014 14:31:24 +0530
Message-ID: <543CE664.5090306@smartplayin.com>
References: <1412840528-31508-1-git-send-email-kiran.padwal@smartplayin.com> <20141013130918.GY27755@sirena.org.uk> <543CC015.6090709@smartplayin.com> <20141014080956.GQ27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141014080956.GQ27755@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 14 October 2014 01:39 PM, Mark Brown wrote:
> On Tue, Oct 14, 2014 at 11:47:57AM +0530, Kiran Padwal wrote:
>> On Monday 13 October 2014 06:39 PM, Mark Brown wrote:
> 
>>> Two problems:
>>>  - I'm missing patches 1 and 2.
> 
>> These patches are same like this one,
>> [1] https://lkml.org/lkml/2014/10/9/58
>> [2] https://lkml.org/lkml/2014/10/9/52
> 
> You should at least be sending the cover letter to everyone so that they
> know what's going on.

OK, I will take care of this next time.

> 
>>>  - This only changes one driver but essentially every SPI driver
>>>    initializes .owner - why is only thi sone driver being changed?
> 
>> Nothing more intention, but just remove superfluous .owner field for drivers which
>> use the module_platform_driver API, as this is overridden in
>> platform_driver_register anyway.
> 
> My point is that doing a change like this to random drivers isn't great,
> if you're going to do this sort of thing it is better to do it for
> everything rather than making things inconsistent.
> 

Sure, I will do that.

Thanks,
--Kiran
