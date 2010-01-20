From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] SPI DaVinci: SPI master driver
	for DaVinci/DA8xx
Date: Wed, 20 Jan 2010 13:47:32 -0700
Message-ID: <fa686aa41001201247i73c92141o133fb5cc0d7e6538@mail.gmail.com>
References: <1261000938-1897-1-git-send-email-s-paulraj@ti.com>
	<878wccqfmp.fsf@deeprootsystems.com>
	<fa686aa41001051641w58ae2b11w476ae2fd8ef325ed@mail.gmail.com>
	<87iqbgnjpq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, s-paulraj-l0cyMroinI0@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87iqbgnjpq.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 5, 2010 at 5:46 PM, Kevin Hilman
<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> writes:
>
>> On Tue, Jan 5, 2010 at 4:46 PM, Kevin Hilman
>> <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
>>> s-paulraj-l0cyMroinI0@public.gmane.org writes:
>>>
>>>> From: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
>>>>
>>>> This patch adds support for a SPI master driver for the
>>>> DaVinci series of SOCs
>>>>
>>>> Signed-off-by: Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>
>>>> Signed-off-by: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
>>>> Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>>>> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
>>>
>>> Sandeep,
>>>
>>> This needs a minor refresh against current Linus tree for the Makefile
>>> change.
>>>
>>> While doing the Makefile addition, it looks like the list is maintained=
 in
>>> alphabetical order. =A0Please add davinci in the right order, and feel =
free to
>>> add my signoff.
>>
>> Signed-of-by lines are only for patches that actually pass through
>> your hands (ie. you add it yourself when you pick it up and pass it).
>> It is not appropriate to add a s-o-b line for someone else.
>> "Acked-by" or "Reviewed-by" should be used instead.
>
> Understood. =A0This driver has passed through my hands (and in front of
> my eyes) in various forms many times in its development, so I figured
> an s-o-b was appropriate.
>
> That being said, for this particular version, and ack is probably more
> appropriate.
>
> Sandeep, after you refresh, please add
>
> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>

If it has been through your hands in some form, then yes a s-o-b is
appropriate.  I'll take care of it.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
