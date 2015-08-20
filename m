From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Fri, 21 Aug 2015 01:47:00 +0200
Message-ID: <55D666F4.2080801@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
 <20150820183634.GN12027@sirena.org.uk> <20150820210822.GH74600@google.com>
 <55D64A65.7030905@osg.samsung.com> <20150820232517.GZ12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
	linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150820232517.GZ12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Mark,

On 08/21/2015 01:25 AM, Mark Brown wrote:
> On Thu, Aug 20, 2015 at 11:45:09PM +0200, Javier Martinez Canillas wrote:
>> On 08/20/2015 11:08 PM, Brian Norris wrote:
> 
>>>> This is tagged as something that can't be applied but you've not
>>>> explained why it can't be applied or what comments might be useful :(
> 
>> As Brian pointed out it was in the cover letter so I thought it would
>> just be duplicated information. But you are right, I should had added
>> a brief note as well just to make the patch self contained.
> 
> Right, a big part of what I was looking for was something about why this
> is an incompatible change in the changelog so that once it gets applied
> someone with out of tree code which gets broken can see what happens.

Yes, you are absolutely right. When I finally post this as a proper
patch I'll make sure to have a big NOTE so people can track module
autoload issues for OF drivers down to this commit.

> Plus...
> 
>>> I believe that's mostly addressed in the cover letter [1].
> 
>>>   Patch #18 changes the logic of spi_uevent() to report an OF modalias
>>>   if the device was registered using OF. But this patch is included in
>>>   the series only as an RFC for illustration purposes since changing
>>>   that without first applying all the other patches in this series, will
>>>   break module autoloading for the drivers of devices registered using
>>>   OF but that lacks an of_match_table. I'll repost patch #18 once all
>>>   the patches in this series have landed.
> 
>>> IOW, it's labeled as such mostly for safety, since it has quite a few
>>> distributed dependencies.
> 
> Are there really only 17 drivers that are missing an explict of_table?
> That seems like a low number.
>

In fact the 17 patches are the combination of the SPI drivers that:

a) Have a .id_table but not a MODULE_DEVICE_TABLE(spi,...)
b) Have a .of_match_table but no a MODULE_DEVICE_TABLE(of,...)
c) Don't have a .of_match_table but have a DT binding document

Maybe there are more SPI drivers out there that only have a .id_table
and don't have a .of_match_table nor a DT binding doc. But in that case
there isn't too much I can do since I've no information that these are
drivers are actually used in systems booted with OF.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
