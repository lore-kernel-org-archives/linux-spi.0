From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/4] Cleaned hexadecimal dump
Date: Sun, 8 Mar 2015 12:53:52 +0200
Message-ID: <CAHp75VcaMDqHMwQcV+p5_KjDviEr97m4e=GFVXkXLgO4pkvmjw@mail.gmail.com>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
	<1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
	<1425781325.16901.27.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adrian Remonda <adrianremonda@gmail.com>,
	Mark Brown <broonie@kernel.org>, corbet@lwn.net,
	linux-spi@vger.kernel.org,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425781325.16901.27.camel@perches.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 8, 2015 at 4:22 AM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2015-03-07 at 12:56 -0500, Adrian Remonda wrote:

>> +static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
>> +{
>
> Is there something necessary that print_hex_dump can't do?

As far as I can see the tool is running in user space. Do we have
possibility to use print_hex_dump() in user space?

-- 
With Best Regards,
Andy Shevchenko
