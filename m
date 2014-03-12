From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 21:13:35 +0400
Message-ID: <CAMo8Bf+mC_ZfECqJ2Apf5rcTJ10hbE55wN1cT7Jv74kzWFuVTg@mail.gmail.com>
References: <1394626865-15105-1-git-send-email-jcmvbkbc@gmail.com>
	<1394626865-15105-2-git-send-email-jcmvbkbc@gmail.com>
	<20140312124901.GQ28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140312124901.GQ28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 12, 2014 at 4:49 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Mar 12, 2014 at 04:21:03PM +0400, Max Filippov wrote:
>
>> +     case 16:
>> +             /* Bytes that should go out earlier have lower addresses,
>> +              * but the hardware operates with 16 bit words and transmits
>> +              * higher bits first. Thus data in memory is in BE order.
>> +              */
>> +             xspi->data = (xspi->data << 16) | be16_to_cpu(v);
>> +             xspi->data_sz += 2;
>> +             break;
>
> Are you sure you need to do this byte swap?  SPI words are big endian so
> if you are running on a little endian processor if you are transmitting
> 16 bit words you should see the data getting swapped on the bus (this is
> why I say you should never have more than 8 bits per word for regmap).

Looks like this swap is not needed: I've looked at drivers that set
bits_per_word = 16, they submit data in cpu endianness. Will fix in v3.

-- 
Thanks.
-- Max
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
