From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI SPI slave device
Date: Thu, 3 Mar 2016 17:45:35 +0000
Message-ID: <20160303174535.GA11728@srcf.ucam.org>
References: <20160229082114.GC1770@lahna.fi.intel.com>
 <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
 <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
 <20160301160726.GA23371@wunner.de>
 <CAAbRKOuESP+_65cmeCPNtO5HzN1+ct7bDv1stbE+a8u=KEwDKw@mail.gmail.com>
 <CAAbRKOsNxsu4CYq=EByck997RWRO3fQ-+LAAS5AbSL3XNRSh7A@mail.gmail.com>
 <20160302114250.GA23487@wunner.de>
 <CAAbRKOvP9yudKbzu_GquPUzhz2VQBtuKYmJbqLpt1jFcB6U1kQ@mail.gmail.com>
 <CAAbRKOs=ySAtqn71Mf5tyHvjqOGGRs5xsO6oU5YPYWgOSXqehA@mail.gmail.com>
 <20160303114740.GA24132@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leif Liddy <leif.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160303114740.GA24132-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 03, 2016 at 12:47:40PM +0100, Lukas Wunner wrote:

> I think you want to add a quirk to spi.c:acpi_spi_add_device()
> which checks if acpi_dev_get_resources() returned nothing and
> the HID of the acpi_device is APP000D: Search the namespace below
> the acpi_device's handle for _CRS.UBUF (using acpi_get_handle()).
> If this exists, call acpi_walk_resource_buffer() on it (with the
> acpi_spi_add_resource callback). You need to somehow convert the
> acpi_handle to an acpi_buffer, maybe that just involves filling in
> acpi_buffer->pointer = acpi_handle and somehow determining the
> length of the resource settings from the handle. Someone more
> intimately familiar with the layout of the namespace in memory
> should be able to answer this. Hopefully this will already get
> you started, if not just ask questions.

If Apple are consistently using this mechanism to define resources, do 
we want to extend acpi_dev_get_resources to attempt to call the _DSM 
method as well?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
