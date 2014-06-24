From: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH 5/6] OF: Utility helper functions for dynamic nodes
Date: Tue, 24 Jun 2014 10:10:01 +0200
Message-ID: <53A93259.8000301@nsn.com>
References: <1403430039-15085-1-git-send-email-pantelis.antoniou@konsulko.com> <1403430039-15085-6-git-send-email-pantelis.antoniou@konsulko.com> <53A85549.7040809@nsn.com> <6E91A461-4361-4A18-BE32-CECDD789C114@konsulko.com> <20140623183343.GA10389@heimdall>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pete Popov <pete.popov-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Dan Malek <dan.male
To: Ioan Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	ext Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140623183343.GA10389@heimdall>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Pantelis, Grant,

On 23/06/14 20:33, Ioan Nicu wrote:
>>> On 22/06/14 11:40, ext Pantelis Antoniou wrote:
>>>> Introduce helper functions for working with the live DT tree,
>>>> all of them related to dynamically adding/removing nodes and
>>>> properties.
>>>>
>>>> __of_copy_property() copies a property dynamically
>>>> __of_create_empty_node() creates an empty node
>>>>
>>>> Bug fix about prop->len == 0 by Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
>>>
>>> Are you sure about this? (see below...)
>>>
> 
> Alexander is right, my fix was lost even though it's mentioned in this patch.
> 
>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
>>>> ---
>>
>> [snip]
>>>> +
>>>> +	if (prop->length > 0) {
>>>        ^^^^^^^^^^^^^^^^^^^^^
>>> Seems, that length==0 case will still produce value==NULL results,
>>> which will brake some checks in the kernel... Or am I missing something in
>>> the new version?
>>>
>>
>> prop->value will be set to NULL, and length will be set to zero (kzalloc).
>> This is a normal zero length property.
>>
>> I don't know of any place in the kernel accessing the value if prop->length==0
>>
> 
> We have a simple use case. We have an overlay which adds an interrupt controller.
> If you look in drivers/of/irq.c, in of_irq_parse_raw():
> 
> [...]
> 	/* Now start the actual "proper" walk of the interrupt tree */
> 	while (ipar != NULL) {
> 		/* Now check if cursor is an interrupt-controller and if it is
> 		 * then we are done
> 		 */
> 		if (of_get_property(ipar, "interrupt-controller", NULL) !=

We have to define, if it's allowed for an empty property to have NULL value.
Several places in the kernel use of_get_property() to check for property existence.
We either have to make a tree-wide patch and replace of_get_property() with of_find_property() in those cases,
or ensure value != NULL in this copy function...

Grant, what do you think?

> 				NULL) {
> 			pr_debug(" -> got it !\n");
> 			return 0;
> 		}
> [...]
> 
> A node is identified as an interrupt controller if it has a zero-length property
> called "interrupt-controller" but with a non-NULL value.
> 
> My proposed fix for this was to remove the if () condition. propn->value will be
> allocated with kmalloc(0) which returns ZERO_SIZE_PTR which is != NULL.
> 
> 
>>
>> [snip]
>>
>>>> +
>>>> #endif /* _LINUX_OF_H */
>>>>
>>>
>>> -- 
>>> Best regards,
>>> Alexander Sverdlin.
>>
>> Regards
>>
>> -- Pantelis
>>
> 
> Regards,
> Ionut Nicu
> 

-- 
Best regards,
Alexander Sverdlin.
