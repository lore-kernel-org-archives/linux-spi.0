From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 09/19] ARM: ux500: Enable SSP (SPI) for HREF when booting
 Device Tree
Date: Tue, 18 Sep 2012 14:13:05 +0200
Message-ID: <50586551.5020404@antcom.de>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org> <1347016499-29354-10-git-send-email-lee.jones@linaro.org> <CACRpkdaC_enpxUFNM_wteAQWKER_naUNUH-s1pJtiGzVFSV+og@mail.gmail.com> <505757D8.8090405@antcom.de> <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com,
	arnd@arndb.de, devicetree-discuss@lists.ozlabs.org,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	spi mailing list <spi-devel-general@lists.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZLdernphVSfwHS43HptS+33=PzorihQ0bBKm689u_oFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 09/18/2012 02:08 PM, Linus Walleij wrote:
>> When we have sorted out this driver change (please check the new pl022
>> specific dt property names!), I will provide patches for arm-soc to
>> actually use this new interface via dts files.
> 
> OK cool I guess you will do this for the LPC32xx? Or are you testing
> this on some other platforms?

LPC32xx for now. The new code is backwards compatible, so I'd prefer for
others to adopt and test it on their platforms individually before
patching everything at once without testing.

Roland
