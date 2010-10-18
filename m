From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 00/28] Blackfin SPI updates for
	2.6.36
Date: Mon, 18 Oct 2010 01:04:20 -0600
Message-ID: <AANLkTimE33PngPfSBkQDVR7x6H8fMNQ9z3sXNC9KZPWf@mail.gmail.com>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
	<20101018062834.GG19399@angua.secretlab.ca>
	<AANLkTims9Z+XGXMdcAH53OBO=S9aYiszxHczmsTn06Gd@mail.gmail.com>
	<AANLkTimmVQ0EtkACtXqxO0vkXfN9FoyF9c6OLo3JNPUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTimmVQ0EtkACtXqxO0vkXfN9FoyF9c6OLo3JNPUC-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 18, 2010 at 12:49 AM, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Oct 18, 2010 at 02:34, Mike Frysinger wrote:
>> On Mon, Oct 18, 2010 at 02:28, Grant Likely wrote:
>>> On Sun, Oct 17, 2010 at 06:59:13PM -0400, Mike Frysinger wrote:
>>>> Quite a bit here, but these patches have been around for a while. =A0T=
he
>>>> reason they haven't been pushed up before was that some of the first
>>>> changes introduced known bugs themselves and needed some manual fixing.
>>>>
>>>> Also, while some files touch Blackfin headers in arch/blackfin/, I'd
>>>> like to keep them in this series and merge through the SPI tree to keep
>>>> conflict issues down, as well as possible breakage due to desync.
>>>>
>>>> These are also available in my 'for-spi' branch of my git tree:
>>>> =A0 =A0 =A0 git://git.kernel.org/pub/scm/linux/kernel/git/vapier/black=
fin.git
>>>
>>> On brief review, the series looks good with a couple of minor comments
>>> (already sent).
>>>
>>> For the spi branch that I push to Linus, I always use the prefix
>>> spi/<driver-name>. =A0If the patches in your branch also use that
>>> prefix, then I'd be happy to pull your tree directly instead of
>>> committing the patches myself. =A0Otherwise, I need to commit them
>>> manually.
>>
>> merged patches thus far have used the convention i picked here, but i
>> dont have a problem with changing them.

Not since I've been maintainer... all 11 months of it.  :-P

> ive rewriitten the logs, addressed your feedback on all the other
> patches, and pushed up the new for-spi branch if you want to double
> check & pull. =A0i dont want to spam people with 30 patches where only
> the summary changed ...

Wise man.  Let me look....  git.kernel.org is being slow...

Hmmm.  Still looks like the old branch (old prefix and no patch 29).
Probably just mirroring being slow.  I'll check again tomorrow
morning.

g.
