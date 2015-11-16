From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 18:32:22 -0300
Message-ID: <564A4B66.6090107@osg.samsung.com>
References: <56104E88.3040807@gmail.com> <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com> <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com> <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com> <564A101F.9090807@osg.samsung.com>
 <20151116192434.GO8456@google.com> <564A35EB.5080008@osg.samsung.com>
 <20151116204702.GP8456@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-mtd@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151116204702.GP8456@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Brian,

On 11/16/2015 05:47 PM, Brian Norris wrote:
> Hi,
> 
> On Mon, Nov 16, 2015 at 05:00:43PM -0300, Javier Martinez Canillas wrote:
>> On 11/16/2015 04:24 PM, Brian Norris wrote:
> 
>> I also didn't think about wilcards... I wonder why there are trailing
>> wildcards for a compatible string. After all a compatible string should
>> define a particular IP and there could be a foo,bar and foo,barbaz that
>> have different drivers and what prevents today the driver with alias
>> of:N*T*Cfoo,bar* to be loaded due a MODALIAS=of:NfooT<NULL>Cfoo,barbar ?
>>
>> So I think we need this regardless of my patch:
>>
>> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
>> index 5b96206e9aab..cd0002f4a199 100644
>> --- a/scripts/mod/file2alias.c
>> +++ b/scripts/mod/file2alias.c
>> @@ -704,7 +704,6 @@ static int do_of_entry (const char *filename, void *symval, char *alias)
>>  		if (isspace (*tmp))
>>  			*tmp = '_';
>>  
>> -	add_wildcard(alias);
>>  	return 1;
>>  }
>>  ADD_TO_DEVTABLE("of", of_device_id, do_of_entry);
> 
> (I'm also not an expert in this stuff, but...) That looks reasonable.
> You might refer to commit ac551828993e ("modpost: i2c aliases need no

Yes, that's exactly the commit I looked to come up with the above diff.

> trailing wildcard") for inspiration. You might also modify the "always"
> in:
> 
> /* Always end in a wildcard, for future extension */
> static inline void add_wildcard(char *str)
> {
> 	...
> }

Indeed.

> 
> And of course, you probably should CC those who are responsible for the
> core device tree probing and device/driver interactions for something
> like this.
> 

Sure.

>> Now that I think about it, there is another issue and is that today spi:foo
>> defines a namespace while changing to of: will make the namespace flat so
>> a platform driver that has the same vendor and model will have the same
>> modalias.
>>
>> IOW, for board files will be platform:bar and i2c:bar while for OF will be
>> of:NfooT<NULL>Cfoo,bar in both cases. I wonder if we should reuse the type
>> for that and store the subsystem prefix there. What do you think?
> 
> I'm not sure I understand all the issues here to be able to comment
> properly. But I bet someone else might.
> 
> (For me, it might help if you had a more concrete example to speak of.)
>

>From a quick look I couldn't find a real example (that doesn't mean there
isn't one) but I'll make one just to explain the problem.

Let's suppose you have 3 different IP's blocks (i.e: pmics) from the same
vendor. The IP's are quite similar but only differ in that use a different
bus to communicate with the SoC.

So you could have a core driver and transport drivers for SPI and I2C.

So currently you could use the not too creative compatible strings compatible
string "acme,my-pmic" in all the drivers and is not a problem because the SPI
and I2C subsystem will always report the MODALIAS uevent as:

MODALIAS=i2c:my-pmic and MODALIAS=spi:my-pmic

so as far as there is a "my-pmic" entry in the SPI and I2C id tables, module
autoload will work and the match will also work since that happens per bus_type.

But if SPI and I2C are migrated to OF modalias reporting, then both I2C and SPI
will report (assuming the device node is called pmic in both cases):

MODALIAS=of:NpmicT<NULL>Cacme,my-pmic

That's what I meant when said that the modalias namespace is flat in the case of
OF but is separated in the case of board files and the current implementation.

What currently the drivers are doing is to name the model my-pmic-{i2c,spi,etc}
but I think that the subsystem information should be explicitly present in the
OF modalias information as it is for legacy device registration.
 
>> Thanks a lot for pointing out all these issues. It is indeed harder than
>> I thought.
> 
> No problem!
> 
>>> I don't think you have problems only with bad FDTs. I think you have a
>>> problem with perfectly valid DTs.
>>>
>>
>> Agreed, I wonder if spi_uevent() shouldn't be changed to report both the
>> OF and old SPI modaliases to avoid breaking a lot of drivers but at the
>> same time allowing DT-only drivers to not need an SPI ID table.
> 
> That's the solution I imagined, though I haven't tested it yet. I don't
> see much precedent for reporting multiple modaliases, so there could be
> some kind of ABI issues around that too.
>

Ok, I'm glad that we agree. This definitely needs to be discussed with more
people. I'll re-spin my patch and post a v2 reporting multiple modaliases
tomorrow after testing.
 
> Regards,
> Brian
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
