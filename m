From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: ACPI SPI slave device
Date: Thu, 3 Mar 2016 17:48:06 +0000
Message-ID: <20160303174806.GB11728@srcf.ucam.org>
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

Oh, sorry, I see - it's a little more complicated than that. Bleah. I 
still think we probably want to do this at the core level rather than 
having the driver special-case things based on the HID, but it's clearly 
going to need some knowledge of the device type to parse Apple's data 
into something consistent with the spec.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
