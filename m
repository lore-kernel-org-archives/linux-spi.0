From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
	select gpio to simplify the common cases
Date: Tue, 9 Sep 2008 10:42:04 +0800
Message-ID: <f17812d70809081942t718aa081p23f4711ee53d8019@mail.gmail.com>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<f17812d70809040403u4c33e376vd8b3a2c5f034081c@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net> <48C5CFEE.6070601@whoi.edu>
	<f17812d70809081842l703fa346k139cc14dc033d877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f17812d70809081842l703fa346k139cc14dc033d877-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 9, 2008 at 9:42 AM, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> +static int setup_cs(struct spi_device *spi, struct chip_data *chip,
>>> +                 struct pxa2xx_spi_chip *chip_info)
>>
>> My understanding is that it is legal to call setup without a defined
>> pointer to a struct pxa2xx_spi_chip in spi_dev->controller_data, if the
>> chip is happy with the defaults (only works for a single chip bus that
>> needs no CS, a degenerate case, but still legal).  Thus you should allow
>> for that by always checking for existence (chip_info not NULL) before use.
>>

Ah, checked again with the source, I don't think setup_cs()
shall continue if (chip_info == NULL), which implies a
null_cs_control(), and is now handled by cs_assert() and
cs_deassert().

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
