From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: [PATCH 4/6] SPI: S3C64XX: Check before mem-region release
Date: Thu, 21 Jan 2010 16:10:14 +0100
Message-ID: <4B586E56.4020804@gmx.net>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-4-git-send-email-jassisinghbrar@gmail.com>
	<fa686aa41001181012s57c0e863s6b9b6b2724514a9f@mail.gmail.com>
	<1b68c6791001181542p618a8d47n45a120e51cfed1f1@mail.gmail.com>
	<fa686aa41001181832r3d2462f6y87649244b8afc5f2@mail.gmail.com>
	<1b68c6791001190152m652fd117k468893144af8dcfe@mail.gmail.com>
	<1b68c6791001201735w3060c54blfa85b547917727c2@mail.gmail.com>
	<1b68c6791001201746p313234bbkdf5fe5db0dcecd9f@mail.gmail.com>
	<fa686aa41001201855m5c054d90nb3652a5b0d3ffd86@mail.gmail.com>
	<1b68c6791001201906r45c52f71h7f5ea396e91ef3b8@mail.gmail.com>
	<fa686aa41001210700p4d06ff45h4db23c9ea03d6ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, Jassi Brar <jassi.brar@samsung.com>,
	jassi brar <jassisinghbrar@gmail.com>, patchwork <patchwork@ozlabs.org>,
	spi-devel-general@lists.sourceforge.net,
	Jeremy Kerr <jeremy.kerr@canonical.com>, ben@trinity.fluff.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <patchwork-bounces+gcvp-patchwork=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <fa686aa41001210700p4d06ff45h4db23c9ea03d6ffb@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/patchwork>,
	<mailto:patchwork-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/patchwork>
List-Post: <mailto:patchwork@lists.ozlabs.org>
List-Help: <mailto:patchwork-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/patchwork>,
	<mailto:patchwork-request@lists.ozlabs.org?subject=subscribe>
Sender: patchwork-bounces+gcvp-patchwork=m.gmane.org@lists.ozlabs.org
Errors-To: patchwork-bounces+gcvp-patchwork=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On 21.01.2010 16:00, Grant Likely wrote:
> On Wed, Jan 20, 2010 at 8:06 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
>   
>> On Thu, Jan 21, 2010 at 11:55 AM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>>     
>>> On Wed, Jan 20, 2010 at 6:46 PM, jassi brar <jassisinghbrar@gmail.com> wrote:
>>>       
>>>> On Thu, Jan 21, 2010 at 10:35 AM, jassi brar <jassisinghbrar@gmail.com> wrote:
>>>>         
>>>>> Hi Grant Likely,
>>>>>  You have reviewed this series of patches but didn't ACK/NAK.
>>>>> Could you kindly confirm if u accept them or want some changes?
>>>>> Thanks.
>>>>>           
>>>> Nevermind, I just saw ur ACK at my official ID (many maintainers reply
>>>> something like
>>>> 'pulled now' to the patch thread but thats ok if you ACK personally).
>>>> Thanks.
>>>>         
>>> I'm using patchwork.kernel.org for collecting spi patches.
>>> Unfortunately patchwork doesn't provide any mechanism for emailing
>>> "merged" messages when I accept patches.  To compensate, I've started
>>> cc'ing patch authors my next- branch update message when I push out an
>>> updated tree.
>>>
>>> You can also always look at patchwork.kernel.org to see if your
>>> patches are still in the queue.  I won't forget accidentally drop any
>>> patches tracked by patchwork.
>>>       
>> well, it might not just be the submitter, but also others in the thread
>> interested in knowing the fate of a particular patch. And having to
>> poll some repo for that, isn't very efficient. It's not important to be notified
>> _when_ you accept the patch, but only _if_ you accept, which I think
>> you would know after seeing the patch and/or some further clarifications
>> from the submitter.
>>     
>
> Since I review patches on patchwork, I don't have an easy link between
> what I'm picking up and my email client.  Only when I need to comment
> on something will I actually go and find the thread in my mailer.  So
> it is considerably less efficient for me to go and reply to every
> patch submission.
>
> Jeremy, would it be possible to have a way of sending out a status
> update email from within patchwork?
>   

There is an unfinished Patchwork patch which allows you to click on a
mailto: link at the beginning of the Patchwork page and your mailer will
preserve threading (sort of, the reply will always be to the original
patch, and the list and the submitter will be in CC). Basically, the
mailto: link has In-Reply-To and Subject headers set to correct values.
It might be possible to extend this a bit and get all responders added
to CC.

That patch is unfinished, though, so if you know Python, Patchwork, and
the framework used by Patchwork you can probably beat it into a shape
that is useful for your purposes. If you're interested, I can dig it up.

Regards,
Carl-Daniel

-- 
Developer quote of the year:
"We are juggling too many chainsaws and flaming arrows and tigers."
