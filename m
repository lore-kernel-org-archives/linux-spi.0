From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: spi: OF module autoloading is still broken
Date: Tue, 17 Nov 2015 10:36:39 -0300
Message-ID: <564B2D67.6060803@osg.samsung.com>
References: <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk> <20151113234857.GK8456@google.com>
 <564A101F.9090807@osg.samsung.com> <20151116192434.GO8456@google.com>
 <564A35EB.5080008@osg.samsung.com> <20151116204702.GP8456@google.com>
 <564A4B66.6090107@osg.samsung.com> <20151116215144.GQ8456@google.com>
 <564B2833.8030100@osg.samsung.com> <20151117131930.GP31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-mtd@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151117131930.GP31303@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Mark,

On 11/17/2015 10:19 AM, Mark Brown wrote:
> On Tue, Nov 17, 2015 at 10:14:27AM -0300, Javier Martinez Canillas wrote:
>> On 11/16/2015 06:51 PM, Brian Norris wrote:
> 
>>> Lest someone else wonder whether this is theoretical or not, I'll save
>>> them the work in pointing at an example: "st,st33zp24". See:
> 
>>> Documentation/devicetree/bindings/security/tpm/st33zp24-*.txt
> 
>>> and the code is in drivers/char/tpm/st33zp24/, sharing the same core
>>> library, suggesting that the devices really are the same except simply
>>> the bus.
> 
>> Thanks for pointing out that example although for that specific case,
>> the drivers' compatible are "st,st33zp24-i2c" and "st,st33zp24-spi" to
>> avoid the issue explained before.
> 
> Eew, that's gross.  
>

Well, I'm not the author of the driver but I've seen many drivers doing
the same so I believe the reason is to avoid the issue explained before.
 
>> I still didn't find an example where the same compatible string is
>> used for different drivers (i.e: "st,st33zp24" or "google,cros-ec")
>> but the fact that is possible for legacy and not for OF is worrisome.
> 
> There's a bunch of audio CODEC and PMIC drivers, arizona is the first
> example that springs to mind but it's very common to have mixed signal
> devices devices which can run in both I2C and SPI modes.
> 

Thanks a lot for the examples, I just looked at the arizona MFD drivers
and indeed the same OF device ID table is used for both the SPI and I2C
drivers.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
