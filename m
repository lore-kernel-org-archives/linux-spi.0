From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 5/6] OF: Utility helper functions for dynamic nodes
Date: Mon, 23 Jun 2014 12:48:26 -0700
Message-ID: <53A8848A.3000803@roeck-us.net>
References: <1403430039-15085-1-git-send-email-pantelis.antoniou@konsulko.com> <1403430039-15085-6-git-send-email-pantelis.antoniou@konsulko.com> <53A85549.7040809@nsn.com> <6E91A461-4361-4A18-BE32-CECDD789C114@konsulko.com> <20140623183343.GA10389@heimdall> <78ACBAF6-A73E-4272-8D3A-258C4B10858C@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pe
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <78ACBAF6-A73E-4272-8D3A-258C4B10858C-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/23/2014 12:13 PM, Pantelis Antoniou wrote:
> Hi Ioan,
>
> I'm going to let Grant answer that but the code in question doesn't look right.
>
> On Jun 23, 2014, at 9:33 PM, Ioan Nicu wrote:
>
>> Hi Pantelis,
>>
>> On Mon, Jun 23, 2014 at 07:57:24PM +0300, ext Pantelis Antoniou wrote:
>>> Hi Alexander,
>>>
>>> On Jun 23, 2014, at 7:26 PM, Alexander Sverdlin wrote:
>>>
>>>> Hello Pantelis!
>>>>
>>>> On 22/06/14 11:40, ext Pantelis Antoniou wrote:
>>>>> Introduce helper functions for working with the live DT tree,
>>>>> all of them related to dynamically adding/removing nodes and
>>>>> properties.
>>>>>
>>>>> __of_copy_property() copies a property dynamically
>>>>> __of_create_empty_node() creates an empty node
>>>>>
>>>>> Bug fix about prop->len == 0 by Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
>>>>
>>>> Are you sure about this? (see below...)
>>>>
>>
>> Alexander is right, my fix was lost even though it's mentioned in this patch.
>>
>
> I'm sorry, I didn't understand that the intention of the fix was to address
> the issue below.
>
>>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>
>>> [snip]
>>>>> +
>>>>> +	if (prop->length > 0) {
>>>>        ^^^^^^^^^^^^^^^^^^^^^
>>>> Seems, that length==0 case will still produce value==NULL results,
>>>> which will brake some checks in the kernel... Or am I missing something in
>>>> the new version?
>>>>
>>>
>>> prop->value will be set to NULL, and length will be set to zero (kzalloc).
>>> This is a normal zero length property.
>>>
>>> I don't know of any place in the kernel accessing the value if prop->length==0
>>>
>>
>> We have a simple use case. We have an overlay which adds an interrupt controller.
>> If you look in drivers/of/irq.c, in of_irq_parse_raw():
>>
>> [...]
>> 	/* Now start the actual "proper" walk of the interrupt tree */
>> 	while (ipar != NULL) {
>> 		/* Now check if cursor is an interrupt-controller and if it is
>> 		 * then we are done
>> 		 */
>> 		if (of_get_property(ipar, "interrupt-controller", NULL) !=
>> 				NULL) {
>> 			pr_debug(" -> got it !\n");
>> 			return 0;
>> 		}
>> [...]
>>
>> A node is identified as an interrupt controller if it has a zero-length property
>> called "interrupt-controller" but with a non-NULL value.
>>
>> My proposed fix for this was to remove the if () condition. propn->value will be
>> allocated with kmalloc(0) which returns ZERO_SIZE_PTR which is != NULL.
>>
>
> If that's the case, the code in irq.c is wrong.
>
> interrupt-controller is a bool property; the correct call to use is of_property_read_bool()
> which returns true or false when the value is defined.
>
> The use of of_get_property is a bug here. It is perfectly valid for a property to have a
> NULL value when length = 0.
>

That usage is spread throughout the code though. There are three or four similar checks
for interrupt-controller in the code, and many others using of_get_property() to check
for booleans.

Some examples:
	s5m8767,pmic-buck2-ramp-enable
	s5m8767,pmic-buck3-ramp-enable
	s5m8767,pmic-buck4-ramp-enable
	d7s-flipped?
	atmel,use-dma-rx
	linux,rs485-enabled-at-boot-time
	marvell,enable-port1 (and many others)
	linux,bootx-noscreen
	linux,opened

and many many others.

Maybe people meant to use of_find_property() ?

Either case, if the new code depends on proper use of of_get_property(), we may have
a problem unless all those bad use cases are fixed.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
