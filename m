From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Mon, 16 Nov 2015 17:00:43 -0300
Message-ID: <564A35EB.5080008@osg.samsung.com>
References: <56104E88.3040807@gmail.com> <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com> <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com> <20151113231410.GV12392@sirena.org.uk>
 <20151113234857.GK8456@google.com> <564A101F.9090807@osg.samsung.com>
 <20151116192434.GO8456@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151116192434.GO8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Brian,

On 11/16/2015 04:24 PM, Brian Norris wrote:
> Hi Javier,
> 
> On Mon, Nov 16, 2015 at 02:19:27PM -0300, Javier Martinez Canillas wrote:
>> On 11/13/2015 08:48 PM, Brian Norris wrote:
>>> On Fri, Nov 13, 2015 at 11:14:10PM +0000, Mark Brown wrote:
>>>> On Fri, Nov 13, 2015 at 02:51:13PM -0800, Brian Norris wrote:
> 
>> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>>
>> And doesn't have a list of compatible strings. It points to a file in
>> the Linux kernel source tree (drivers/mtd/devices/m25p80.c) which IMHO
>> is wrong since the bindings should be OS agnostic. So instead, a list
>> of the valid compatible strings (with both manufacturer and model)
>> should be documented there.
> 
> Yep, that's a sore spot that I'm aware of. We had enough trouble sorting
> out what "jedec,spi-nor" would be, and I never moved on to the point of
> fixing up that comment. Will do that this week.
> 
>> The fact that having compatible = "garbage,valid-model" or "valid-model"
>> worked was just a fortunate event due how the SPI core currently works.
> 
> I'd call that "unfortunate", and I agree with Mark. Implementation
> matters more than documentation when talking about ABI.
> 
> 

Right, by fortunate I meant "just working by luck" but it seems I had
chosen the wrong words and I agree that the event is indeed unfortunate.

>>> No "nor-jedec" -- that was an intermediate name that got replaced
>>> mid-release-cycle due to some late DT review comments.
>>>
>>
>> I think the comments in the m25p80 driver should be updated then since I
>> had the same confusion when reading the spi_device_id table.
> 
> Oops, thanks for pointing that out. That's old garbage that should be
> cleaned up. Will patch that soon.
>

You are welcome.

>>> But yes, I suppose adding "spi-nor" back to the spi_device_id table
>>> fixes *one* of the immediate problems (i.e., 'compatible =
>>> "jedec,spi-nor"'). That would cover Heiner's report. But it doesn't
>>> solve:
>>>
>>>   compatible = "vendor,shiny-new-device", "jedec,spi-nor"
>>>
>>> I believe that the latter is sometimes the Right Way (TM) to do things
>>> for device tree, so you have a fallback if auto-probing "jedec,spi-nor"
>>> ever doesn't suffice.
>>>
>>> (This came up in Heiner's original post: "In case of m25p80 this means
>>> that "jedec,spi-nor" has to be the first "compatible" value. This
>>> constraint might be too strict ..")
>>>
>>
>> I don't believe Heiner's statement is correct or maybe I misunderstood how
>> module alias is reported for OF based platforms. But IIRC what happens is
>> that the of_device_get_modalias() concatenates all the compatible strings
>> that are present in the OF node.
> 
> Heiner was only talking about the existing SPI core code, which doesn't
> use of_device_get_modalias().
>

OK.
 
>> So in this particular example the reported modalias would be:
>>
>> of:Nshiny-new-deviceT<NULL>Cvendor,shiny-new-deviceCjedec,spi-nor
>>
>> and since the modaliases that will be stored in the module would be:
>>
>> alias: of:N*T*Cjedec,spi-nor*
>>
>> the latter will match the former since all compatible strings are in the
>> reported modalias and the of_device_id .name was not set so is a wilcard.
>>
>> If there is also a "vendor,shiny-new-device", then the aliases would be:
>>
>> alias: of:N*T*Cvendor,shiny-new-device*
>> alias: of:N*T*Cjedec,spi-nor*
>>
>> so of:N*T*Cvendor,shiny-new-device* will also match
>> of:Nshiny-new-deviceT<NULL>Cvendor,shiny-new-deviceCjedec,spi-nor
>>
>> That covers the two use cases for valid compatible strings AFAICT and DT
>> using invalid compatible strings should not be tried to be supported IMHO.
> 
> But it doesn't cover cases like this:
> 
> 	compatible = "vendor,m25p80";
> 
> which today yield uevent/modalias:
> 
> 	spi:m25p80
> 
> and will match with m25p80.c's spi_device_id table (and therefore will
> autoload). Your patch will change this to:
> 
> 	of:N*T*vendor,m25p80*
> 
> and unless I go and add "vendor,m25p80" to m25p80's of_match_table as
> well, then this will NOT autoload. But, see how this can't be extended
> to wildcard matches? So I think your patch requires a bit more thought
> and care, or else you will break a lot more than you think.
> 

You are absolutely right, I have a script that should had found this case
(DT in mainline that are relying on the SPI device ID table to match a
model used in a compatible string) but it seems my script has some bugs
since it didn't find the IDs for this driver.

I also didn't think about wilcards... I wonder why there are trailing
wildcards for a compatible string. After all a compatible string should
define a particular IP and there could be a foo,bar and foo,barbaz that
have different drivers and what prevents today the driver with alias
of:N*T*Cfoo,bar* to be loaded due a MODALIAS=of:NfooT<NULL>Cfoo,barbar ?

So I think we need this regardless of my patch:

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5b96206e9aab..cd0002f4a199 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -704,7 +704,6 @@ static int do_of_entry (const char *filename, void *symval, char *alias)
 		if (isspace (*tmp))
 			*tmp = '_';
 
-	add_wildcard(alias);
 	return 1;
 }
 ADD_TO_DEVTABLE("of", of_device_id, do_of_entry);

Now that I think about it, there is another issue and is that today spi:foo
defines a namespace while changing to of: will make the namespace flat so
a platform driver that has the same vendor and model will have the same
modalias.

IOW, for board files will be platform:bar and i2c:bar while for OF will be
of:NfooT<NULL>Cfoo,bar in both cases. I wonder if we should reuse the type
for that and store the subsystem prefix there. What do you think?

Thanks a lot for pointing out all these issues. It is indeed harder than
I thought.

>> I will of course add a comment to my patch explaining what could break when
>> the SPI core is modified to report a proper OF modalias
> 
>> but I don't think we
>> should try to maintain FDTs that were not doing the right thing with regard
>> to using wrong and undocumented compatible strings.
> 
> I don't think you have problems only with bad FDTs. I think you have a
> problem with perfectly valid DTs.
>

Agreed, I wonder if spi_uevent() shouldn't be changed to report both the
OF and old SPI modaliases to avoid breaking a lot of drivers but at the
same time allowing DT-only drivers to not need an SPI ID table.
 
> Brian
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
