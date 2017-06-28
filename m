From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI / property: Support Apple _DSM properties
Date: Wed, 28 Jun 2017 21:53:49 +0300
Message-ID: <CAHp75VdjOcPkd0_g05_OW6amxHjf2zdJ9jKyH7q2AgzGMr-h4w@mail.gmail.com>
References: <cover.1498636759.git.lukas@wunner.de> <e72ce423489dd604ae98ad3b76e07caf944cb581.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e72ce423489dd604ae98ad3b76e07caf944cb581.1498636759.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 28, 2017 at 8:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> While the rest of the world has standardized on _DSD as the way to store
> device properties in AML (introduced with ACPI 5.1 in 2014), Apple has
> been using a custom _DSM to achieve the same for much longer (ever since
> they switched from DeviceTree-based PowerPC to Intel in 2005, verified
> with MacOS X 10.4.11).

> +/**
> + * acpi_retrieve_apple_properties - retrieve and convert Apple _DSM properties
> + * @adev: ACPI device for which to retrieve the properties
> + *
> + * Invoke Apple's custom _DSM once to check the protocol version and once more
> + * to retrieve the properties.  They are marshalled up in a single package as
> + * alternating key/value elements, unlike _DSD which stores them as a package
> + * of 2-element packages.  Convert to _DSD format and make them available under
> + * the primary fwnode.
> + */
> +static void acpi_retrieve_apple_properties(struct acpi_device *adev)
> +{
> +       unsigned int i, j, newsize = 0, numprops, skipped = 0;
> +       union acpi_object *props, *newprops;
> +       void *free_space;
> +

> +       if (!IS_ENABLED(CONFIG_X86) || !dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
> +               return;

You are using this in few places, perhaps it makes sense to do in
(maybe) header like
drivers/acpi/apple.h

static inline bool is_apple_system(void)
{
   return IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.");
}

I know this makes more LOCs, the rationale is to keep such
deterministic things in one place (basically maintenance).

Rafael, Mika?

> +       /* newsize = key length + value length of each tuple */
> +       numprops = props->package.count / 2;
> +       for (i = 0; i < numprops; i++) {
> +               union acpi_object *key = &props->package.elements[i * 2];
> +               union acpi_object *val = &props->package.elements[i * 2 + 1];
> +
> +               if ( key->type != ACPI_TYPE_STRING ||
> +                   (val->type != ACPI_TYPE_INTEGER &&
> +                    val->type != ACPI_TYPE_BUFFER)) {
> +                       key->type = ACPI_TYPE_ANY; /* mark as to be skipped */
> +                       skipped++;
> +                       continue;
> +               }
> +               newsize += key->string.length + 1;
> +               if ( val->type == ACPI_TYPE_BUFFER)
> +                       newsize += val->buffer.length;
> +       }
> +
> +       if (skipped)
> +               acpi_handle_info(adev->handle, FW_INFO
> +                                "skipped %u properties: wrong type\n",
> +                                skipped);
> +       if (skipped == numprops)
> +               goto out_free;
> +
> +       /* newsize += top-level package + 3 objects for each key/value tuple */
> +       newsize += (1 + 3 * (numprops - skipped)) * sizeof(union acpi_object);
> +       newprops = ACPI_ALLOCATE_ZEROED(newsize);
> +       if (!newprops)
> +               goto out_free;
> +
> +       /* layout: top-level package | packages | key/value tuples | strings */
> +       newprops->type = ACPI_TYPE_PACKAGE;
> +       newprops->package.count = numprops - skipped;
> +       newprops->package.elements = &newprops[1];
> +       free_space = &newprops[1 + 3 * (numprops - skipped)];
> +

> +       for (i = 0, j = 0; i < numprops; i++) {

Instead I would rather to create a bitmask above and do here something like

for_each_bit_set()

(Note, we have a lot of helpers to work with bitmaps)

> +               union acpi_object *key = &props->package.elements[i * 2];
> +               union acpi_object *val = &props->package.elements[i * 2 + 1];

> +               unsigned int k = (1 + numprops - skipped) + j * 2;
> +               unsigned int v = k + 1; /* index into newprops */

...and this rather complex arithmetics will go away.

> +
> +               if (key->type == ACPI_TYPE_ANY)
> +                       continue; /* skipped */

...and this.

> +
> +               newprops[1 + j].type = ACPI_TYPE_PACKAGE;
> +               newprops[1 + j].package.count = 2;
> +               newprops[1 + j].package.elements = &newprops[k];
> +
> +               newprops[k].type = ACPI_TYPE_STRING;
> +               newprops[k].string.length = key->string.length;
> +               newprops[k].string.pointer = free_space;
> +               memcpy(free_space, key->string.pointer, key->string.length);
> +               free_space += key->string.length + 1;
> +
> +               newprops[v].type = val->type;
> +               if (val->type == ACPI_TYPE_INTEGER)
> +                       newprops[v].integer.value = val->integer.value;

> +               else {

checkpatch.pl ?

> +                       newprops[v].buffer.length = val->buffer.length;
> +                       newprops[v].buffer.pointer = free_space;
> +                       memcpy(free_space, val->buffer.pointer,
> +                              val->buffer.length);
> +                       free_space += val->buffer.length;
> +               }

> +               j++; /* not incremented for skipped properties */

> +       }

-- 
With Best Regards,
Andy Shevchenko
